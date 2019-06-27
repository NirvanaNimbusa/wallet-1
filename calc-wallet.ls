require! {
    \./api.ls : { get-balance }
    \./math.ls : { times, plus }
    \prelude-ls : { find, map, pairs-to-obj, foldl, filter }
    \./plugin-loader.ls : { get-coins }
    \./workflow.ls : { run, task }
    \./round5.ls
    #\./pending-tx.ls : { get-pending-amount }
    \./transactions.ls : { transactions }
}
calc-wallet = (store, cb)->
    return cb "Store is required" if not store?
    { wallets } = store.current.account
    { rates } = store
    state =
        balance-usd: 0
    coins = get-coins!
    build-loader = (wallet)-> task (cb)->
        { token } = wallet.coin
        #wallet.balance = \...
        #wallet.balance-usd = 0
        token = wallet.coin.token.to-lower-case!
        usd-rate = rates[token] ? \..
        wallet.usd-rate =
            | usd-rate is \.. => \..
            | _ => round5 usd-rate
        eur-rate = 0.893191
        wallet.eur-rate =
            | usd-rate is \.. => \..
            | _ => round5 (usd-rate `times` eur-rate)
        coin =
            coins |> find (.token is wallet.coin.token)
        return cb "Coin Not Found" if not coin?
        coin.wallet = wallet
        err, balance <- get-balance { wallet.address, wallet.network, token, account: { wallet.address, wallet.private-key } }
        return cb err if err?
        pending-sent =
            transactions 
                |> filter (.token is token)
                |> filter (.pending is yes)
                |> map (.amount)
                |> foldl plus, 0
        #err, pending-sent <- get-pending-amount { store, token, wallet.network }
        #console.log { err, pending-sent }
        wallet.pending-sent = pending-sent
        wallet.balance = balance
        wallet.balance-usd =
            | usd-rate is \.. => \..
            | _ => balance `times` usd-rate
        state.balance-usd =
            | usd-rate is \.. => \..
            | _ => state.balance-usd `plus` wallet.balance-usd
        cb!
    loaders =
        wallets |> map build-loader
    tasks =
        loaders 
            |> map -> [loaders.index-of(it).to-string!, it]
            |> pairs-to-obj
    <- run [tasks] .then
    return cb err if err?
    store.current.balance-usd = round5 state.balance-usd
    cb null
module.exports = calc-wallet