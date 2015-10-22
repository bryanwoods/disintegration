$ ->
  allCharacters = $('#body').text().trim().split("")
  nonEmptyCharacters = _.reject allCharacters, (char) -> char is " "
  randomCharacter = _.sample(nonEmptyCharacters)

  $.ajax "/project/#{randomCharacter}", method: "DELETE"
