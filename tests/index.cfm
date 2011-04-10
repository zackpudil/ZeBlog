<cfscript>
	testSuite = createObject("component", "mxunit.framework.TestSuite").TestSuite();
	
	testSuite.addAll("ZeBlog.tests.services.PeopleServiceTest");
	testSuite.addAll("ZeBlog.tests.services.AdminServiceTest");
	testSuite.addAll("ZeBlog.tests.services.MainServiceTest");
	
	results = testSuite.run();
	writeOutput(results.getResultsOutput('html'));
</cfscript>