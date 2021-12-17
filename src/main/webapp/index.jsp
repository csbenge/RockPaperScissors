<html>
<head>
<title>Rock Paper Scissors!!!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<html>
   <body>
     <div class="container">
       <h1>Choose your move.</hr><br/>
       <div class="btn-group" role="group" aria-label="Basic mixed styles example">
        <button type="button" class="btn btn-danger"  onclick="playRPS('rock')">Rock</button>
        <button type="button" class="btn btn-warning" onclick="playRPS('paper')">Paper</button>
        <button type="button" class="btn btn-success" onclick="playRPS('scissors')">Scissors</button>
      </div>
    </div>

    <div class="container">
      <table class="table">
      <thead>
        <tr>
          <th scope="col">RESULT</th>
          <th scope="col">WINS</th>
          <th scope="col">LOSS</th>
          <th scope="col">TIES</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><div id="results"></div></td>
          <td><div id="wins"></div></td>
          <td><div id="losses"></div></td>
          <td><div id="ties"></div></td>
        </tr>
      </table>
    </div>

    <div class="container">
      <div id="results"></div>
      <div id="wins"></div>
      <div id="losses"></div>
      <div id="ties"></div>
      <div id="history"></div>
    </div>

   </body>
</html>

<script>
function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}


playRPS = function(clientGesture) {
	console.log("************** ROCK-PAPER-SCISSORS **************");
   let gameService = new GameService();
   let gameSummary = gameService.playGame(clientGesture);
   let theScore    = gameService.getScore();
   theScore.increaseRound();

   /* console.log("Here is the returned gs: " + gameSummary + " :---:"); */

   document.getElementById('results').innerHTML = gameSummary.result;
   document.getElementById('wins').innerHTML = theScore.wins;
   document.getElementById('losses').innerHTML = theScore.losses;
   document.getElementById('ties').innerHTML = theScore.ties;

   renderGameHistory(gameService.getGameHistory());
}


renderGameHistory = function(gameHistory){
	/* console.log("************** RENDERING GAME HISTORY *****************"); */
	let output = "<table class='table table-striped'><tr><th>User</th><th>Computer</th><th>Result</th><th>Date</th></tr>";
	for (let i=0; i < gameHistory.length; i++){
		let gameSummary = gameHistory[i];
		let date = gameSummary.date;
		/* console.log(gameSummary); */
    if (gameSummary.result==("win")) {
			badge = "<span class='badge bg-success'>";
    }
    if (gameSummary.result==("lose")) {
			badge = "<span class='badge bg-danger'>";
    }
    if (gameSummary.result==("tie")) {
			badge = "<span class='badge bg-secondary'>";
    }
		output = output + " <tr>";
		output = output + " <td> " + gameSummary.clientGesture + " </td> ";
		output = output + " <td> " + gameSummary.serverGesture  + " </td> ";
		output = output + " <td> " + badge + gameSummary.result + "</span>" + " </td> ";
		output = output + " <td> " + date + " </td> ";
		output = output + " </tr>";
		/* console.log(output); */
	}
	output = output + "</table>";
	document.getElementById('history').innerHTML = output;
}
</script>


<script>
function Score() {

	this.wins   = 0;
	this.losses = 0;
	this.ties   = 0;
  this.round  = 1;

	this.increaseWins = function(){
		this.wins++;
	}
	this.increaseLosses = function(){
		this.losses++;
	}
	this.increaseTies = function(){
		this.ties++;
	}
  this.increaseRound = function(){
		this.round++;
	}
	this.toString = function(){
		output = "Wins: " + this.wins + " Ties: " + this.ties + " Losses: " + this.losses;
		return output;
	}
}
</script>


<script>
function GameSummary(client, server, result) {

	this.clientGesture=client;
	this.serverGesture=server;
	this.result=result;
	this.date=new Date();

	this.getClientGesture = function(){
		this.clientGesture;
	}

	this.getServerGesture = function(){
		this.serverGesture;
	}

	this.getResult = function(){
		this.result;
	}

	this.getDate = function(){
		this.date;
	}

	this.toString = function() {
		let output = "User :: " + this.clientGesture;
		let simpleDate = this.date.toLocaleDateString("en-US");
		output = output + " :: Computer :: " + this.serverGesture;
		output = output + " :: Result :: " + this.result;
		output = output + " :: Time played :: " + simpleDate;
		return output;
	}
}
</script>


<script>
let theScore = new Score();
var gameHistory =[];
function GameService() {

	this.getScore = function() {
		return theScore;
	}

	this.getGameHistory = function() {
		return gameHistory;
	}

	this.playGame = function(userMove) {

    let options = ['rock', 'paper', 'scissors']
    let computer = getRandomInt(3);
    let computerMove = options[computer];

		let result = "error";

    /* tie */
    if (userMove==computerMove) {
      result = "tie";
      theScore.increaseTies();
    }

    /* user wins */
		if (userMove==("scissors") && computerMove==("paper")) {
			result = "win";
			theScore.increaseWins();
		}

		if (userMove==("paper") && computerMove==("rock")) {
			result = "win";
			theScore.increaseWins();
		}

    if (userMove==("rock") && computerMove==("scissors")) {
			result = "win";
			theScore.increaseWins();
		}

    /* computer wins */
    if (userMove==("rock") && computerMove==("paper")) {
			result = "lose";
			theScore.increaseLosses();
		}

    if (userMove==("scissors") && computerMove==("rock")) {
			result = "lose";
			theScore.increaseLosses();
		}

    if (userMove==("paper") && computerMove==("scissors")) {
			result = "lose";
			theScore.increaseLosses();
		}


		if (result == "error") { return; }

    let output = "Round: " + theScore.round;
    output     = output + " | User: " + userMove;
    output     = output + " | Computer: " + computerMove;
    output     = output + " || Result: " + result
		console.log(output);

		let gameSummary = new GameSummary(userMove, computerMove, result);
    console.log(theScore.toString());
		gameHistory.unshift(gameSummary);
		this.printGameHistory(gameHistory);


		/* console.log("Number of wins: " + theScore.wins); */
		/* console.log(gameSummary + " :: "); */
		return gameSummary;
	}


	this.printGameHistory = function(gameHistory){
		console.log("********* GAME HISTORY *********");
		let aggregate = "";
		for (let i=0; i < gameHistory.length; i++){
			let gameSummary = gameHistory[i];
			/* console.log(gameSummary); */
			let output = "Client :: " + gameSummary.clientGesture;
			output = output + " :: Server :: " + gameSummary.serverGesture;
			output = output + " :: Result :: " + gameSummary.result;
			output = output + " :: Time played :: " + gameSummary.date;
			console.log(output);
			aggregate =  aggregate + output + "<br/>";
		}
		document.getElementById('history').innerHTML = aggregate;
		console.log("********* END OF GAME HISTORY *********");
	}
}

</script>
