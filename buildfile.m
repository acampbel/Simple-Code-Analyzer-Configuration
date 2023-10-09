function plan = buildfile
import matlab.buildtool.tasks.*;

plan = buildplan;

plan("lint") = CodeIssuesTask(Results="results/issues.sarif");
plan("clean") = CleanTask;

plan.DefaultTasks = "lint";

end
