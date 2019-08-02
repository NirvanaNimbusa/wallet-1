require! {
    \./navigate.ls
    \./seed.ls : { set }
    \bip39 : { generate-mnemonic }
    \./pages/confirmation.ls : { confirm }
    \prelude-ls : { words, map, filter, join }
}
clean = ->
    it.match(/[a-z]+/)?0
fix =  
    words >> (map clean) >> (filter (?)) >> (join " ")
module.exports = (store)->
    generate-seed = ->
        store.current.seed = generate-mnemonic!
        store.current.seed-temp = store.current.seed
    perform-change-seed = ->
        store.current.seed = store.current.seed-temp
    change-seed = (event)->
        store.current.seed-temp = event.target.value
        change-seed.timeout = clear-timeout change-seed.timeout
        change-seed.timeout = set-timeout perform-change-seed, 1000
    save = ->
        return alert "Secret key cannot be empty" if store.current.seed.length is 0
        return alert "Secret key is so weak" if store.current.seed.length < 20
        confirmed <- confirm store, "Please confirm that you stored this phrase in safe place?"
        return if confirmed isnt yes
        store.current.saved-seed = yes
        set store.current.seed
        navigate store, \:init
    has-issue = ->
        return no if store.current.seed.length is 0
        not store.current.seed.match(/^([a-z]+[ ]){0,11}([a-z]+)$/)?
    fix-issue = ->
        store.current.seed = fix store.current.seed
        store.current.seed-temp = store.current.seed
    { save, change-seed, generate-seed, has-issue, fix-issue }