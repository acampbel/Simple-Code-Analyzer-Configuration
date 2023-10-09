function plan = buildfile
import matlab.buildtool.tasks.*;

plan = buildplan(localfunctions);

plan("lint") = CodeIssuesTask(Results="results/issues.sarif");
plan("lint").Dependencies = "clean";

plan("strictConfig").Inputs = "codeAnalyzerConfiguration.json";
plan("strictConfig").Outputs = "resources/codeAnalyzerConfiguration.json";

plan("strict_lint") = CodeIssuesTask(Results="results/issues-strict.sarif");
plan("strict_lint").Dependencies = "strictConfig";

plan("clean") = CleanTask;

plan.DefaultTasks = ["lint" "strict_lint"];

end

function strictConfigTask(~)

if ~isfolder("resources")
    mkdir("resources");
end
copyfile("codeAnalyzerConfiguration.json","resources");

end
