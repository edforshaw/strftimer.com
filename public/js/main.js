document.addEventListener("DOMContentLoaded", function() {
  var httpRequest;
  var queryTimeout;
  var currentQuery;

  var output = document.getElementById("output");
  var instructions = document.getElementById("instructions");
  var strftime = document.getElementById("strftime");
  var directives = document.getElementById("directives");
  var help = document.getElementById("help");

  function processQuery(e) {
    var query = e.target.value;

    clearTimeout(queryTimeout);
    if (e.keyCode == 13) request(query);
    else
      queryTimeout = setTimeout(request, 400, query);
  }

  function request(query) {
    if (currentQuery === query) return
    currentQuery = query

    httpRequest = new XMLHttpRequest();
    httpRequest.onreadystatechange = processUpdate;
    httpRequest.open("GET", "/translate?query="+encodeURIComponent(query));
    httpRequest.send();
  }

  function processUpdate() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      output.style.opacity = "0";

      if (httpRequest.status === 200) {
        var data = JSON.parse(httpRequest.responseText);
        setTimeout(updateSuccess, 150, data);
      } else {
        setTimeout(updateFailure, 150);
      }
    }
  }

  function updateSuccess(data) {
    instructions.style.display = "none";
    strftime.style.display = "inline";
    directives.textContent = data.translation;

    if (data.help) {
      help.innerHTML = data.help;
      help.style.display = "block";
    } else {
      help.textContent = "";
      help.style.display = "none";
    }

    output.style.opacity = "1";
  }

  function updateFailure() {
    instructions.style.display = "inline";
    strftime.style.display = "none";
    directives.textContent = "";
    help.textContent = "";
    help.style.display = "none";
    output.style.opacity = "1";
  }

  document.getElementById("query").addEventListener("keyup", processQuery);
});
