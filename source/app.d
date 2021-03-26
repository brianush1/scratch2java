import std.stdio;

int main(string[] args) {
	string[] files;
	foreach (arg; args[1 .. $]) {
		files ~= arg;
	}
	if (files == []) {
		stderr.writeln("error: no files provided");
		return 1;
	}
	foreach (file; files) {
		import std.path : baseName, dirName, buildPath;
		import scratch : ScratchProject;
		import java : compile, camelize;

		auto project = new ScratchProject(file);

		string output = file;
		if (output.length >= 4 && output[$ - 4 .. $] == ".sb3")
			output = output[0 .. $ - 4];
		string className = output.baseName.camelize;
		output = file.dirName.buildPath(className ~ ".java");

		File outFile = File(output, "w");
		outFile.write(compile(project, className));
		outFile.close();
	}
	return 0;
}
