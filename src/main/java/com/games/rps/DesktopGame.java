package com.games.rps;

import javax.swing.JOptionPane;
import java.util.Random;

public class DesktopGame {
	public static String[] options =  {"rock", "paper", "scissors"};

	public static void main(String[] args) {

		String prompt = "Will it be rock, paper or scissors?";
		Score score   = new Score();
		java.util.Vector<GameSummary> history = new java.util.Vector<GameSummary>();
		Random random = new Random();

		while (true) {
			String result = "error";
			String userMove = JOptionPane.showInputDialog(prompt);
			int r = random.nextInt(2 - 0 + 1) + 0;
			String computerMove = options[r];

			/* tie */
			if (userMove.equals(computerMove)) {
				result = "tie";
				score.increaseTies();
			}

			/* user wins */
			if (userMove.equals("scissors") && computerMove.equals("paper")) {
				result = "win";
				score.increaseWins();
			}

			if (userMove.equals("paper") && computerMove.equals("rock")) {
				result = "win";
				score.increaseWins();
			}

	    if (userMove.equals("rock") && computerMove.equals("scissors")) {
				result = "win";
				score.increaseWins();
			}

	    /* computer wins */
	    if (userMove.equals("rock") && computerMove.equals("paper")) {
				result = "lose";
				score.increaseLosses();
			}

	    if (userMove.equals("scissors") && computerMove.equals("rock")) {
				result = "lose";
				score.increaseLosses();
			}

	    if (userMove.equals("paper") && computerMove.equals("scissors")) {
				result = "lose";
				score.increaseLosses();
			}

			GameSummary gs = new GameSummary(userMove, computerMove, result);
			history.add(gs);

			for (GameSummary gameSummary : history) {
				System.out.println(gameSummary);
			}
			System.out.println(score);
			JOptionPane.showMessageDialog(null, result);

		}
	}
}
