package tools {
	public class StringCalculator {
		private static const DEFAULT_DELIMITER:String = ",";
		private static const NEW_DELIMITER_TOKEN:String = "//";
		private static const NEW_LINE_TOKEN:String = "\n";
		private static const BEGIN_DELIMITER_TOKEN:String = "[";
		private static const END_DELIMITER_TOKEN:String = "]";
		
		public function StringCalculator() { }
		
		// sum a list of numbers
		public function add(numbers:String):int  {
			var delimiters:Array = [DEFAULT_DELIMITER];
			
			// check for new delimiters
			if (isNewDelimiter(numbers)){
				delimiters = getNewDelimiters(numbers);
				numbers = removeChangeDelimiterFromInput(numbers);
			}
			
			// parse numbers from input
			var finalNumbers:Array = extractNumbersFromInput(numbers, delimiters);
			
			// abort if theres is any negative number
			checkNegativeNumbers(finalNumbers);
			
			// Numbers greater than 1000 must be ignored
			finalNumbers = removeNumbersGreaterThan1000(finalNumbers);
			
			// Finally add the numbers
			var sum:int = sumListOfNumbers(finalNumbers);
			
			return sum;
		}

		private function getNewDelimiters(numbers:String):Array {
			// Extract delimiters between brackets
			var ret:Array = [DEFAULT_DELIMITER];
			var posIni:int = numbers.indexOf(BEGIN_DELIMITER_TOKEN);
			if (posIni == -1) {
				ret.push(numbers.charAt(2));
			} else {
				while (posIni != -1) {
					var posFin:int = numbers.indexOf(END_DELIMITER_TOKEN, posIni);
					ret.push(numbers.substring(posIni + 1, posFin));
					posIni = numbers.indexOf(BEGIN_DELIMITER_TOKEN, posFin);
				}
			}
			return ret;
		}
		private function isNewDelimiter(numbers:String):Boolean  {
			return (numbers != "" && numbers.substring(0, 2) == NEW_DELIMITER_TOKEN);
		}
		
		private function removeChangeDelimiterFromInput(numbers:String):String {
			var pos:int = numbers.indexOf(NEW_LINE_TOKEN);
			return  numbers.substring(pos, numbers.length);
		}

		private function extractNumbersFromInput(numbers:String, delimiters:Array):Array {

			var finalNumbers:Array = new Array();
			
			if (numbers != "") {
				// Convert all delimiters to the default delimiter
				for each (var delimiter:String in delimiters) {
					if (delimiter != DEFAULT_DELIMITER) {
						var parts:Array = numbers.split(delimiter);
						numbers = parts.join(DEFAULT_DELIMITER);
					}
				}
				
				var sumandos:Array = numbers.split(DEFAULT_DELIMITER);
				
				for (var i:int = 0; i < sumandos.length; i++)  {
					var sumando:String = String(sumandos[i]);
					var pos:int = sumando.indexOf(NEW_LINE_TOKEN);
					if (pos == sumando.length-1)
						throw new Error("New Line not permited at the end");
					if (pos != -1) {
						finalNumbers.push(sumando.substring(0, pos));
						finalNumbers.push(sumando.substring(pos + 1, sumando.length));
					} else {
						finalNumbers.push(sumandos[i]);
					}
				}
			}
			
			return finalNumbers;
		}

		private function checkNegativeNumbers(finalNumbers:Array):void {
			var negativeNumbers:Array = new Array();
			for each (var item:int in finalNumbers) {
				if (int(item) < 0)
					negativeNumbers.push(item);
			}
			
			if (negativeNumbers.length > 0) {
				throw Error("Negative numbers not allowed: " + negativeNumbers.join(","));
			}
		}

		private function removeNumbersGreaterThan1000(numbers:Array):Array {
			var otherNumbers:Array = [];
			for each (var item:int in numbers) {
				if (item <= 1000)
					otherNumbers.push(item);
			}
			return otherNumbers;
		}
		
		private function sumListOfNumbers(finalNumbers:Array):int {
			var sum:int = 0;
			for each (var item:int in finalNumbers) {
				sum += int(item);
			}
			return sum;
		}
	}
}