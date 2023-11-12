import QtQuick 2.15
import QtWebView 1.0

WebView {
    anchors.fill: parent
    url: "about:blank"

    function get() {
        var pokemons = []
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "https://pokeapi.co/api/v2/pokemon?limit=10", true)

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText)
                    var pokemonList = response.results
                    pokemonList.forEach(pokemon => pokemons.push(pokemon))
                    console.log(pokemons)
                    return pokemons
                }
            }
            xhr.send()
        }
    }
}
