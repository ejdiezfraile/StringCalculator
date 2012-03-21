package tools.stringCalculator {
	import org.flexunit.Assert;
	import tools.StringCalculator;
	public class StringCalculatorTest {
		private var stringCalculator:StringCalculator;

		[Before]
		// run before each test method
		public function runBeforeEveryTest():void {
			stringCalculator = new StringCalculator();
		}
		[After]
		// run after each test method
		public function RunAfterEveryTest():void { }
		
		
		[Test (description = "emptyString")]
		public function emptyStringReturnsZero():void {
			var numbers:String = "";
			var expected:int = 0;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function oneNumberReturnsTheNumber():void {
			var numbers:String = "1";
			var expected:int = 1;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function twoNumbersSepartedByComma():void {
			var numbers:String = "1,2";
			var expected:int = 3;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function unknowAmountOfNumbers():void {
			var numbers:String = "1,2,3,4,5";
			var expected:int = 15;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function newLineBetweenNumbers():void {
			var numbers:String = "1\n2,3";
			var expected:int = 6;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test(expects = "Error")]
		public function newLineBetweenAnyNumber():void {
			var numbers:String = "1,\n";
			var expected:int = -1;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function changeDelimiterSemicolon():void {
			var numbers:String = "//;\n1;2";
			var expected:int = 3;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function changeDelimiterAsterisk():void {
			var numbers:String = "//*\n1*2*3*4";
			var expected:int = 10;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function negativeNumberNotAllowed():void {
			var numbers:String = "-1,2";
			var actual:String = null;
			var expected:String = "Negative numbers not allowed: -1";
			try
			{
				var dumb:int = stringCalculator.add(numbers);
				Assert.fail("Exception expected");
			} catch (e:Error) {
				trace(e.message);
			}
		}
		
		[Test]
		public function negativeNumbersNotAllowed():void {
			var numbers:String = "-1,2,-5";
			var actual:String = null;
			var expected:String = "Negative numbers not allowed: -1,-5";
			try
			{
				var dumb:int = stringCalculator.add(numbers);
				Assert.fail("Exception expected");
			} catch (e:Error) {
				actual = e.message;
			}
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function ignoreNumbersGreaterThanThousand():void {
			var numbers:String = "2,1001,3";
			var expected:int = 5;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function varyingSizeDelimiters():void {
			var numbers:String = "//[***]\n1***2***3";
			var expected:int = 6;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function multipleDelimitersOneChar():void {
			var numbers:String = "//[*][%]\n1*2%3";
			var expected:int = 6;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}
		
		[Test]
		public function multipleDelimitersLongherThanOneChar():void {
			var numbers:String = "//[***][%%]\n1***2%%3";
			var expected:int = 6;
			
			var actual:int = stringCalculator.add(numbers);
			
			Assert.assertEquals(expected, actual);
		}

	}

}