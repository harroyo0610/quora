$(document).ready(function() {
	
$("#votes_positives").on("click", function(event){

  var valor = $("#votes_positives").attr("value")
  event.preventDefault();
  $.post("/positive_vote/", {id_vote: valor}, function(data){
    var valor_pos = $( "#val-positive" ).attr("value");
    console.log(data);
    console.log(valor_pos)
    $( "#val-positive" ).text(valor_pos + " - Voto Positivo");
  });
  
  });


$("#votes_negatives").on("click", function(event){

  var valor = $("#votes_negatives").attr("value")
  event.preventDefault();
  $.post("/negative_vote/", {id_vote: valor}, function(data){
    var valor_pos = $( "#val-negative" ).attr("value");
    console.log(data);
    console.log(valor_pos)
    $( "#val-negative" ).text(valor_pos + " - Voto Negativo");
  });
  
  });
});