# TXCCleanReporter
A XCTests reporter that prints a clean summary of the tests

## Instalation
All that you have to do is to Drag&Drop the folder CleanTestsObserver into your tests target.
Make sure to set the files as members of Tests target.

## Usage
Just run the tests as usually. The only thing that will differ is the output on console. :)

#### Default XCTests reporter
```` console
Test Suite 'All tests' started at 2015-09-10 10:23:45.722
Test Suite 'XCCleanReporterTests.xctest' started at 2015-09-10 10:23:45.723
Test Suite 'TXCCleanReporterTests' started at 2015-09-10 10:23:45.723
Test Case '-[XCCleanReporterTests.TXCCleanReporterTests testReturnsSum_WhenGivenAnArrayOfIntegers]' started.
Test Case '-[XCCleanReporterTests.TXCCleanReporterTests testReturnsSum_WhenGivenAnArrayOfIntegers]' passed (0.001 seconds).
Test Suite 'TXCCleanReporterTests' passed at 2015-09-10 10:23:45.725.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.001 (0.001) seconds
Test Suite 'XCCleanReporterTests.xctest' passed at 2015-09-10 10:23:45.725.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.001 (0.002) seconds
Test Suite 'All tests' passed at 2015-09-10 10:23:45.725.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.001 (0.003) seconds
````


#### With TXCCleanReporter
```` console 
TXCCleanReporterTests: ✓


Finished in 0.038555 seconds
1 examples, All green 
`````

## Licence
MIT license

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.