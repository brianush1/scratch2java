module java;
import scratch;
import arsd.mvd;

string compile(ScratchProject project, string className) {
	currentProject = project;
	procs.clear;
	argsMap.clear;
	seenFlag = false;
	string[] result = [q"(import java.util.*;
import java.io.*;
class )" ~ className ~ q"( {
	static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
	static String answer = "";
	static boolean toBool(String x) {
		return x.equals("true");
	}
	static long toLong(String x) {
		try {
			return (long) Math.round(Double.parseDouble(x));
		}
		catch (NumberFormatException ex) {
			return 0;
		}
	}
	static double toDouble(String x) {
		try {
			return Double.parseDouble(x);
		}
		catch (NumberFormatException ex) {
			return 0.0;
		}
	}
	static String add(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		double res = lhs + rhs;
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String subtract(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		double res = lhs - rhs;
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String multiply(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		double res = lhs * rhs;
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String divide(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		double res = lhs / rhs;
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String random(String a, String b) {
		double from = toDouble(a);
		double to = toDouble(b);
		boolean anyDecimal = a.contains(".") || b.contains(".");
		if (from > to) {
			double t = from;
			from = to;
			to = t;
		}
		if (anyDecimal) {
			return Double.toString(Math.random() * (to - from) + from);
		}
		else {
			return Long.toString((long) Math.floor(Math.random() * (to - from + 1) + from));
		}
	}
	static String greaterThan(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		return lhs > rhs ? "true" : "false";
	}
	static String lessThan(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		return lhs < rhs ? "true" : "false";
	}
	static String equal(String a, String b) {
		try {
			return Double.parseDouble(a) == Double.parseDouble(b) ? "true" : "false";
		}
		catch (NumberFormatException ex) {
			return a.toLowerCase().equals(b.toLowerCase()) ? "true" : "false";
		}
	}
	static String and(String a, String b) {
		return toBool(a) && toBool(b) ? "true" : "false";
	}
	static String or(String a, String b) {
		return toBool(a) || toBool(b) ? "true" : "false";
	}
	static String not(String a) {
		return !toBool(a) ? "true" : "false";
	}
	static String letterOf(String letter, String str) {
		int index = (int) Math.round(toDouble(letter));
		if (index < 1 || index > str.length()) {
			return "";
		}
		else {
			return str.substring(index - 1, index);
		}
	}
	static String length(String str) {
		return Integer.toString(str.length());
	}
	static String contains(String haystack, String needle) {
		return haystack.toLowerCase().contains(needle.toLowerCase()) ? "true" : "false";
	}
	static String mod(String a, String b) {
		double lhs = toDouble(a);
		double rhs = toDouble(b);
		double res = lhs % rhs;
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String round(String a) {
		return Long.toString((long) Math.round(toDouble(a)));
	}
	static String abs(String a) {
		double res = Math.abs(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String floor(String a) {
		double res = Math.floor(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String ceiling(String a) {
		double res = Math.ceil(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String sqrt(String a) {
		double res = Math.sqrt(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String sin(String a) {
		double res = Math.sin(Math.toRadians(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String cos(String a) {
		double res = Math.cos(Math.toRadians(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String tan(String a) {
		double res = Math.tan(Math.toRadians(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String asin(String a) {
		double res = Math.toDegrees(Math.asin(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String acos(String a) {
		double res = Math.toDegrees(Math.acos(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String atan(String a) {
		double res = Math.toDegrees(Math.atan(toDouble(a)));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String ln(String a) {
		double res = Math.log(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String log(String a) {
		double res = Math.log10(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String exp(String a) {
		double res = Math.exp(toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static String exp10(String a) {
		double res = Math.pow(10.0, toDouble(a));
		if (res % 1 == 0) {
			return Long.toString((long) res);
		}
		else {
			return Double.toString(res);
		}
	}
	static void addToList(ArrayList<String> list, String item) {
		list.add(item);
	}
	static void delete(ArrayList<String> list, String index_) {
		int index = (int) toLong(index_);
		if (index >= 1 && index <= list.size()) {
			list.remove(index - 1);
		}
	}
	static void replace(ArrayList<String> list, String index_, String item) {
		int index = (int) toLong(index_);
		if (index >= 1 && index <= list.size()) {
			list.set(index - 1, item);
		}
	}
	static String itemOfList(ArrayList<String> list, String index_) {
		int index = (int) toLong(index_);
		if (index < 1 || index > list.size()) {
			return "";
		}
		else {
			return list.get(index - 1);
		}
	}
)"];
	foreach (sprite; project.sprites) {
		if (project.stage !is sprite) {
			result ~= "\tstatic " ~ sprite.uniqueName ~ " instance_"
				~ sprite.uniqueName ~ " = new " ~ sprite.uniqueName ~ "();";
		}
	}
	foreach (sprite; project.sprites) {
		result ~= sprite.compile.indent;
	}
	if (entrySprite) {
		result ~= [
			"public static void main(String[] args) throws Exception {",
			"\tinstance_" ~ entrySprite.uniqueName ~ ".main();",
			"}",
		].join.indent;
	}
	result ~= "}";
	return result.join;
}

string camelize(string str) {
	import std.regex : ctRegex, replaceAll, Captures;

	return str.replaceAll!((Captures!string m) {
		import std.string : toUpper;

		return m.hit[$ - 1 .. $].toUpper;
	})(ctRegex!r"[\-\. ].").replaceAll(ctRegex!r"[^a-zA-Z0-9]", "");
}

private:

struct Procedure {
	string proccode;
	string[] argumentIds;
}

size_t[Procedure] procs;
size_t[string] argsMap;

string nameProc(Procedure proc) {
	import std.conv : to;

	static size_t procCount;
	if (proc in procs) {
		return "proc" ~ procs[proc].to!string;
	}
	else {
		procCount += 1;
		procs[proc] = procCount;
		return "proc" ~ procCount.to!string;
	}
}

string nameArg(string arg) {
	import std.conv : to;

	static size_t argCount;
	if (arg in argsMap) {
		return "arg" ~ argsMap[arg].to!string;
	}
	else {
		argCount += 1;
		argsMap[arg] = argCount;
		return "arg" ~ argCount.to!string;
	}
}

Procedure mutation2proc(Mutation mutation) {
	import std.json : parseJSON;
	import std.algorithm : map;
	import std.array : array;

	Procedure proc;
	proc.proccode = mutation.proccode;
	proc.argumentIds = parseJSON(mutation.argumentids).array.map!(x => x.get!string).array;
	return proc;
}

ScratchProject currentProject;
Sprite entrySprite;
bool seenFlag;

string compile(Sprite sprite) {
	import std.algorithm : map, joiner;
	import std.array : array;
	import std.conv : to;

	if (currentProject.stage is sprite) {
		string[] result;
		foreach (var; sprite.vars) {
			result ~= "static String var_" ~ var.uniqueName ~ " = " ~ var.initValue.quote ~ ";";
		}
		foreach (list; sprite.lists) {
			result ~= "static ArrayList<String> var_" ~ list.uniqueName
			~ " = new ArrayList<>(Arrays.asList("
			~ list.initValue.map!quote.joiner(", ").array.to!string
			~ "));";
		}
		foreach (block; sprite.blocks) {
			if (auto flagBlock = cast(WhenFlagClicked) block) {
				import std.exception : enforce;

				enforce(!seenFlag, new Exception("only one entry point is allowed in the program"));
				seenFlag = true;
				result ~= [
					"static void main(String[] args) throws Exception {",
					flagBlock.children.compile.indent,
					"}",
				];
			}
			else if (cast(HatBlock) block) {
				result ~= block.compile;
			}
		}
		return result.join;
	}
	else {
		string[] result;
		result ~= "static class " ~ sprite.uniqueName ~ " {";
		foreach (var; sprite.vars) {
			result ~= "\tString var_" ~ var.uniqueName ~ " = " ~ var.initValue.quote ~ ";";
		}
		foreach (list; sprite.lists) {
			result ~= "\tArrayList<String> var_" ~ list.uniqueName
			~ " = new ArrayList<>(Arrays.asList("
			~ list.initValue.map!quote.joiner(", ").array.to!string
			~ "));";
		}
		foreach (block; sprite.blocks) {
			if (cast(HatBlock) block) {
				result ~= block.compile.indent;
			}
		}
		result ~= "}";
		return result.join;
	}
}

string compile(Block block) {
	return mvd!_compile(block);
}

string compile(StackBlock[] substack) {
	import std.algorithm : map;
	import std.array : array;

	return substack.map!compile.array.join;
}

string quote(string str) {
	import std.conv : to;
	import std.exception : enforce;

	wchar[] arr;
	foreach (wchar c; str) {
		if (c >= ' ' && c <= '~') {
			if (c == '"' || c == '\\') {
				arr ~= '\\';
				arr ~= c;
			}
			else {
				arr ~= c;
			}
		}
		else if (c == '\n') {
			arr ~= "\\n"w;
		}
		else {
			enforce(0); // TODO: support unicode
		}
	}
	return "\"" ~ arr.to!string ~ "\"";
}

string join(string[] arr) {
	import std.algorithm : joiner, map, filter;
	import std.conv : to;

	return arr.filter!(x => x != "").map!(x => x == "\n" ? "" : x).joiner("\n").to!string;
}

string indent(string str) {
	import std.regex : ctRegex, replaceAll;

	return "\t" ~ str.replaceAll(ctRegex!r"\n", "\n\t");
}

string _compile(Say block) {
	return "System.out.println(" ~ block.message.compile ~ ");";
}

string _compile(WhenFlagClicked block) {
	import std.exception : enforce;

	enforce(!seenFlag, new Exception("only one entry point is allowed in the program"));
	seenFlag = true;
	entrySprite = block.parent;
	return [
		"void main() throws Exception {",
		block.children.compile.indent,
		"}",
	].join;
}

size_t i = -1;

string iStr() {
	import std.conv : to;

	if (i == 0) return "";
	return i.to!string;
}

string _compile(Repeat block) {
	i += 1;
	return [
		"long c" ~ iStr ~ " = toLong(" ~ block.times.compile ~ ");",
		"for (long i" ~ iStr ~ " = 0; i" ~ iStr ~ " < c" ~ iStr ~ "; i" ~ iStr ~ "++) {",
		block.substack.compile.indent,
		"}",
	].join;
}

string _compile(If block) {
	return [
		"if (toBool(" ~ block.condition.compile ~ ")) {",
		block.substack.compile.indent,
		"}",
	].join;
}

string _compile(IfElse block) {
	return [
		"if (toBool(" ~ block.condition.compile ~ ")) {",
		block.substack.compile.indent,
		"}",
		"else {",
		block.substack2.compile.indent,
		"}",
	].join;
}

string _compile(RepeatUntil block) {
	return [
		"while (!toBool(" ~ block.condition.compile ~ ")) {",
		block.substack.compile.indent,
		"}",
	].join;
}

string _compile(AskAndWait block) {
	return [
		"answer = reader.readLine();"
	].join;
}

string _compile(Answer block) {
	return "answer";
}

string _compile(Add block) {
	return "add(" ~ block.num1.compile ~ ", " ~ block.num2.compile ~ ")";
}

string _compile(Subtract block) {
	return "subtract(" ~ block.num1.compile ~ ", " ~ block.num2.compile ~ ")";
}

string _compile(Multiply block) {
	return "multiply(" ~ block.num1.compile ~ ", " ~ block.num2.compile ~ ")";
}

string _compile(Divide block) {
	return "divide(" ~ block.num1.compile ~ ", " ~ block.num2.compile ~ ")";
}

string _compile(Random block) {
	return "random(" ~ block.from.compile ~ ", " ~ block.to.compile ~ ")";
}

string _compile(GreaterThan block) {
	return "greaterThan(" ~ block.operand1.compile ~ ", " ~ block.operand2.compile ~ ")";
}

string _compile(LessThan block) {
	return "lessThan(" ~ block.operand1.compile ~ ", " ~ block.operand2.compile ~ ")";
}

string _compile(Equals block) {
	return "equal(" ~ block.operand1.compile ~ ", " ~ block.operand2.compile ~ ")";
}

string _compile(And block) {
	return "and(" ~ block.operand1.compile ~ ", " ~ block.operand2.compile ~ ")";
}

string _compile(Or block) {
	return "or(" ~ block.operand1.compile ~ ", " ~ block.operand2.compile ~ ")";
}

string _compile(Not block) {
	return "not(" ~ block.operand.compile ~ ")";
}

string _compile(Join block) {
	return "(" ~ block.string1.compile ~ " + " ~ block.string2.compile ~ ")";
}

string _compile(LetterOf block) {
	return "letterOf(" ~ block.letter.compile ~ ", " ~ block.string.compile ~ ")";
}

string _compile(Length block) {
	return "length(" ~ block.string.compile ~ ")";
}

string _compile(Contains block) {
	return "contains(" ~ block.string1.compile ~ ", " ~ block.string2.compile ~ ")";
}

string _compile(Mod block) {
	return "mod(" ~ block.num1.compile ~ ", " ~ block.num2.compile ~ ")";
}

string _compile(Round block) {
	return "round(" ~ block.num.compile ~ ")";
}

string _compile(MathOp block) {
	import std.exception : enforce;
	import std.algorithm : canFind;

	string op;
	if ([
		"abs", "floor", "ceiling",
		"sqrt", "sin", "cos", "tan",
		"asin", "acos", "atan", "ln",
		"log",
	].canFind(block.operator)) {
		op = block.operator;
	}
	else if (block.operator == "e ^") {
		op = "exp";
	}
	else if (block.operator == "10 ^") {
		op = "exp10";
	}
	enforce(op != "");
	return op ~ "(" ~ block.num.compile ~ ")";
}

string _compile(VariableReporter block) {
	string varName = currentProject.varMap[block.id];
	return "var_" ~ varName;
}

string _compile(SetVariableTo block) {
	string varName = currentProject.varMap[block.variable[1]];
	return "var_" ~ varName ~ " = " ~ block.value.compile ~ ";";
}

string _compile(ChangeVariableBy block) {
	string varName = currentProject.varMap[block.variable[1]];
	return "var_" ~ varName ~ " = add(var_" ~ varName ~ ", " ~ block.value.compile ~ ");";
}

string _compile(AddToList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "addToList(var_" ~ varName ~ ", " ~ block.item.compile ~ ");";
}

string _compile(DeleteOfList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "delete(var_" ~ varName ~ ", " ~ block.index.compile ~ ");";
}

string _compile(DeleteAllOfList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "var_" ~ varName ~ ".clear();";
}

string _compile(ReplaceItemOfList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "replace(var_" ~ varName
		~ ", " ~ block.index.compile
		~ ", " ~ block.item.compile ~ ");";
}

string _compile(ItemOfList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "itemOfList(var_" ~ varName ~ ", " ~ block.index.compile ~ ")";
}

string _compile(LengthOfList block) {
	string varName = currentProject.varMap[block.list[1]];
	return "Integer.toString(var_" ~ varName ~ ".size())";
}

string _compile(ProcedureCall block) {
	import std.algorithm : map, joiner;
	import std.array : array;
	import std.conv : to;
	import std.json : parseJSON;

	Procedure proc = block.mutation.mutation2proc;
	string[] args;
	foreach (i, paramId; proc.argumentIds) {
		args ~= (cast(ReporterBlock) block.inputs[paramId]).compile;
	}
	return proc.nameProc ~ "(" ~ args.joiner(", ").array.to!string ~ ");";
}

string[string] currentArgs;

string _compile(ProcedureDefinition block) {
	import std.algorithm : map, joiner;
	import std.array : array;
	import std.conv : to;
	import std.json : parseJSON;

	Mutation mutation = (cast(ProcedurePrototype) block.customBlock).mutation;
	Procedure proc = mutation.mutation2proc;
	string[] paramNames = parseJSON(mutation.argumentnames).array.map!(x => x.get!string).array;
	string[] params;
	foreach (i, paramId; proc.argumentIds) {
		params ~= nameArg(paramId);
		currentArgs[paramNames[i]] = nameArg(paramId);
	}
	return [
		"void " ~ proc.nameProc ~ "(" ~ params
			.map!(x => "String " ~ x)
			.joiner(", ").array.to!string ~ ") {",
		block.children.compile.indent,
		"}",
	].join;
}

string _compile(ArgumentString block) {
	return currentArgs[block.value];
}

string _compile(LiteralBlock block) {
	return block.value.quote;
}
