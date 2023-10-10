function plan = buildfile
import matlab.buildtool.tasks.*;

plan = buildplan(localfunctions);

plan("lint") = CodeIssuesTask(Results="results/issues.sarif");
plan("lint").Dependencies = "clean";

plan("strictConfig").Inputs = "codeAnalyzerConfiguration.json";
plan("strictConfig").Outputs = "resources/codeAnalyzerConfiguration.json";

plan("strictLint") = CodeIssuesTask(Results="results/strictIssues.sarif", ErrorThreshold=8);
plan("strictLint").Dependencies = "strictConfig";

plan("clean") = CleanTask;

plan.DefaultTasks = ["lint" "strictLint"];

end

function strictConfigTask(~)

if ~isfolder("resources")
    mkdir("resources");
end
copyfile("codeAnalyzerConfiguration.json","resources");

end
