# Import Dangerfile rules from github

danger.import_dangerfile(github: 'johnknapprs/danger-sentiment')

gradle_test_report = 'build/test-results/test/TEST-InjectedTest.xml'

if File.exist?(gradle_test_report)
    junit.parse(gradle_test_report)
    junit.report
else
    message("Unable to find gradle report at #{gradle_test_report}. No test results found")
end
