DISTCLEANFILES = *.log *.results oscap_debug.log.*
CLEANFILES = *.log *.results oscap_debug.log.*

TESTS_ENVIRONMENT = \
		builddir=$(top_builddir) \
		OSCAP_FULL_VALIDATION=1 \
		$(top_builddir)/run

TESTS = test_sce.sh \
		test_passing_vars.sh \
		test_check_engine_results.sh \
		test_sce_parse_errors.sh \
		test_sce_in_ds.sh \
		test_sce_in_report.sh \
		test_sce_stdout_stderr.sh \
		test_sce_streams_fill.sh

EXTRA_DIST =	test_sce.sh \
		sce_xccdf.xml \
		bash_list.sh \
		bash_passer.sh \
		lua_passer.lua \
		python_passer.py \
		python_is16.py \
		test_check_engine_results.sh \
		test_check_engine_results.xccdf.xml \
		empty_stdout.sh \
		test_passing_vars.sh \
		test_passing_vars_sce.sh \
		test_passing_vars_xccdf.xml \
		test_sce_in_ds.sh \
		test_sce_in_ds.xml \
		test_sce_in_report.sh \
		test_sce_in_report.xml \
		test_sce_parse_errors-invalid-oval.xml \
		test_sce_parse_errors_load_corrupted_xml.xccdf.xml \
		test_sce_parse_errors_load_script.xccdf.xml \
		test_sce_parse_errors_script.sh \
		test_sce_parse_errors.sh \
		test_sce_parse_errors_stub-oval.xml \
		test_sce_stdout_stderr.sh \
		test_sce_stdout_stderr.xccdf.xml \
		stdout_stderr.sh \
		test_sce_streams_fill.sh \
		test_sce_streams_fill.xccdf.xml \
		streams_fill.sh
