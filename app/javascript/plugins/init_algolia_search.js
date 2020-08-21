import algoliasearch from "algoliasearch";

const algoliaSearch = () => {
  const inputField = document.querySelector("#search");
  var instantsearch = require('instantsearch.js');

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Equipment');

    inputField.addEventListener("input", () => {
      index.search(inputField.value).then((content) => {

        // instantsearch.widgets.searchBox({
        //   container: document.querySelector('#search'),
        // });
        console.log(content.query);
        // inputField = content.query;
        // handle results however you like...
      })
    });
  }
}


const changePrice = () => {

  const booking = document.getElementById("booking_days");
  const initialPrice = document.getElementById("total-price").innerText;

  booking.addEventListener("input", (event) => {
    const days = event.target.value;
    const price = document.getElementById("total-price");
    price.innerText = initialPrice * days;
  });
};




export { algoliaSearch };
