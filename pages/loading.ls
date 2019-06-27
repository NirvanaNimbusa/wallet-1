require! {
    \react
}
.loading-page
    @import scheme
    $gradient: $primary - 20
    text-align: center
    overflow: hidden
    height: 100%
    >.loading
        position: absolute
        top: calc(50% - 32px)
        left: calc(50% - 32px)
        width: 64px
        height: 64px
        border-radius: 50%
        perspective: 800px
        >.inner
            position: absolute
            box-sizing: border-box
            width: 100%
            height: 100%
            border-radius: 50%
            &.one
                left: 0%
                top: 0%
                animation: rotate-one 1s linear infinite
                border-bottom: 3px solid #EFEFFA
                &.black
                    border-bottom: 3px solid #7083e8   
            &.two
                right: 0%
                top: 0%
                animation: rotate-two 1s linear infinite
                border-right: 3px solid #EFEFFA
                &.black
                    border-right: 3px solid #7083e8
            &.three
                right: 0%
                bottom: 0%
                animation: rotate-three 1s linear infinite
                border-top: 3px solid #EFEFFA
                &.black
                    border-right: 3px solid #7083e8
        @keyframes rotate-one
            0%
                transform: rotateX(35deg) rotateY(-45deg) rotateZ(0deg)
            100%
                transform: rotateX(35deg) rotateY(-45deg) rotateZ(360deg)
        @keyframes rotate-two
            0%
                transform: rotateX(50deg) rotateY(10deg) rotateZ(0deg)
            100%
                transform: rotateX(50deg) rotateY(10deg) rotateZ(360deg)
        @keyframes rotate-three
            0%
                transform: rotateX(35deg) rotateY(55deg) rotateZ(0deg)
            100%
                transform: rotateX(35deg) rotateY(55deg) rotateZ(360deg)
module.exports = (add-class)->
    .loading-page.pug(key="loading")
        .loading.pug
            .inner.one.pug(key="loading-1" class="#{add-class}")
            .inner.two.pug(key="loading-2" class="#{add-class}")
            .inner.three.pug(key="loading-3" class="#{add-class}")