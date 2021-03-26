module scratch;
import std.json;
import std.exception;

private {
	struct BlockSerialize {
		string opcode;
	}

	struct Input {
		string name;
	}

	enum ScratchField;
}

// Motion

// Looks

@BlockSerialize("looks_say")
final class Say : StackBlock {
	ReporterBlock message;
}

// Sound

// Events

@BlockSerialize("event_whenflagclicked")
final class WhenFlagClicked : HatBlock {

}

// Control

@BlockSerialize("control_repeat")
final class Repeat : StackBlock {
	StackBlock[] substack;
	ReporterBlock times;
}

@BlockSerialize("control_if")
final class If : StackBlock {
	StackBlock[] substack;
	ReporterBlock condition;
}

@BlockSerialize("control_if_else")
final class IfElse : StackBlock {
	StackBlock[] substack;
	StackBlock[] substack2;
	ReporterBlock condition;
}

@BlockSerialize("control_repeat_until")
final class RepeatUntil : StackBlock {
	StackBlock[] substack;
	ReporterBlock condition;
}

// Sensing

@BlockSerialize("sensing_askandwait")
final class AskAndWait : StackBlock {
	ReporterBlock question;
}

@BlockSerialize("sensing_answer")
final class Answer : ReporterBlock {

}

// Operators

@BlockSerialize("operator_add")
final class Add : ReporterBlock {
	ReporterBlock num1;
	ReporterBlock num2;
}

@BlockSerialize("operator_subtract")
final class Subtract : ReporterBlock {
	ReporterBlock num1;
	ReporterBlock num2;
}

@BlockSerialize("operator_multiply")
final class Multiply : ReporterBlock {
	ReporterBlock num1;
	ReporterBlock num2;
}

@BlockSerialize("operator_divide")
final class Divide : ReporterBlock {
	ReporterBlock num1;
	ReporterBlock num2;
}

@BlockSerialize("operator_random")
final class Random : ReporterBlock {
	ReporterBlock from;
	ReporterBlock to;
}

@BlockSerialize("operator_gt")
final class GreaterThan : ReporterBlock {
	ReporterBlock operand1;
	ReporterBlock operand2;
}

@BlockSerialize("operator_lt")
final class LessThan : ReporterBlock {
	ReporterBlock operand1;
	ReporterBlock operand2;
}

@BlockSerialize("operator_equals")
final class Equals : ReporterBlock {
	ReporterBlock operand1;
	ReporterBlock operand2;
}

@BlockSerialize("operator_and")
final class And : ReporterBlock {
	ReporterBlock operand1;
	ReporterBlock operand2;
}

@BlockSerialize("operator_or")
final class Or : ReporterBlock {
	ReporterBlock operand1;
	ReporterBlock operand2;
}

@BlockSerialize("operator_not")
final class Not : ReporterBlock {
	ReporterBlock operand;
}

@BlockSerialize("operator_join")
final class Join : ReporterBlock {
	ReporterBlock string1;
	ReporterBlock string2;
}

@BlockSerialize("operator_letter_of")
final class LetterOf : ReporterBlock {
	ReporterBlock letter;
	ReporterBlock string;
}

@BlockSerialize("operator_length")
final class Length : ReporterBlock {
	ReporterBlock string;
}

@BlockSerialize("operator_contains")
final class Contains : ReporterBlock {
	ReporterBlock string1;
	ReporterBlock string2;
}

@BlockSerialize("operator_mod")
final class Mod : ReporterBlock {
	ReporterBlock num1;
	ReporterBlock num2;
}

@BlockSerialize("operator_round")
final class Round : ReporterBlock {
	ReporterBlock num;
}

@BlockSerialize("operator_mathop")
final class MathOp : ReporterBlock {
	ReporterBlock num;

	@ScratchField
	string operator;
}

// Variables

final class VariableReporter : ReporterBlock {
	string id;
}

@BlockSerialize("data_setvariableto")
final class SetVariableTo : StackBlock {
	ReporterBlock value;

	@ScratchField
	string[2] variable;
}

@BlockSerialize("data_changevariableby")
final class ChangeVariableBy : StackBlock {
	ReporterBlock value;

	@ScratchField
	string[2] variable;
}

@BlockSerialize("data_addtolist")
final class AddToList : StackBlock {
	ReporterBlock item;

	@ScratchField
	string[2] list;
}

@BlockSerialize("data_deleteoflist")
final class DeleteOfList : StackBlock {
	ReporterBlock index;

	@ScratchField
	string[2] list;
}

@BlockSerialize("data_deletealloflist")
final class DeleteAllOfList : StackBlock {
	@ScratchField
	string[2] list;
}

@BlockSerialize("data_replaceitemoflist")
final class ReplaceItemOfList : StackBlock {
	ReporterBlock index;
	ReporterBlock item;

	@ScratchField
	string[2] list;
}

@BlockSerialize("data_itemoflist")
final class ItemOfList : ReporterBlock {
	ReporterBlock index;

	@ScratchField
	string[2] list;
}

@BlockSerialize("data_lengthoflist")
final class LengthOfList : ReporterBlock {
	@ScratchField
	string[2] list;
}

//

struct Mutation {
	string proccode;
	string argumentids;
	string argumentnames;
}

@BlockSerialize("procedures_call")
final class ProcedureCall : StackBlock {
	Block[string] inputs;
	Mutation mutation;
}

@BlockSerialize("procedures_definition")
final class ProcedureDefinition : HatBlock {
	@Input("custom_block")
	Block customBlock;
}

@BlockSerialize("procedures_prototype")
final class ProcedurePrototype : Block {
	Mutation mutation;
}

@BlockSerialize("argument_reporter_string_number")
final class ArgumentString : ReporterBlock {
	@ScratchField
	string value;
}

abstract class Block {

	string blockId;
	Sprite parent;

	override string toString() const {
		return typeid(this).name ~ " (" ~ blockId ~ ")";
	}

}

abstract class HatBlock : Block {
	StackBlock[] children;
}

abstract class StackBlock : Block {

}

abstract class ReporterBlock : Block {

}

final class LiteralBlock : ReporterBlock {
	string value;
}

template getBlockByOpcode(string opcode) {
	alias getBlockByOpcode = __traits(getMember, scratch, {
		import std.traits : isAbstractClass;

		static foreach (string memberName; __traits(allMembers, scratch)) {{
			alias Member = __traits(getMember, scratch, memberName);
			static if (is(Member == class) && is(Member : Block)
					&& !isAbstractClass!Member) {
				
			}
		}}
		assert(0);
	}());
}

immutable(string[]) recognizedOpcodes = {
	import std.traits : getSymbolsByUDA, getUDAs;

	string[] result;
	static foreach (T; getSymbolsByUDA!(scratch, BlockSerialize)) {{
		result ~= getUDAs!(T, BlockSerialize)[0].opcode;
	}}
	return result;
}();

struct Variable {
	string id;
	string name;
	string uniqueName;
	string initValue;
}

struct List {
	string id;
	string name;
	string uniqueName;
	string[] initValue;
}

final class Sprite {
	Block[string] blocks;
	string name;
	string uniqueName;
	Variable[] vars;
	List[] lists;

private:

	size_t index;
	ScratchProject project;

	auto deserializeBlock(T : Block)(string id, JSONValue value) {
		import std.traits : FieldNameTuple;

		T result = new T;
		result.blockId = id;
		result.parent = this;
		Block[string] inputs;
		foreach (inputName, input; value["inputs"].object) {
			Block inputBlock;
			JSONValue inputJson = input[1];
			if (inputJson.type == JSONType.string) {
				inputBlock = readBlock(input[1].get!string);
			}
			else {
				int type = cast(int) inputJson[0].get!double;
				if (type >= 4 && type <= 10) {
					LiteralBlock literal = new LiteralBlock;
					literal.parent = this;
					literal.value = inputJson[1].get!string;
					inputBlock = literal;
				}
				else if (type == 11) {
					assert(0); // TODO
				}
				else if (type == 12) {
					VariableReporter var = new VariableReporter;
					var.parent = this;
					var.id = inputJson[2].get!string;
					inputBlock = var;
				}
				else if (type == 13) {
					assert(0); // TODO
				}
			}
			inputs[inputName] = inputBlock;
		}
		static if (__traits(compiles, result.inputs)) {
			result.inputs = inputs;
		}
		static foreach (field; FieldNameTuple!T) {{
			import std.algorithm : map;
			import std.array : array;
			import std.conv : to;
			import std.string : toUpper;
			import std.traits : hasUDA, getUDAs;

			alias Field = __traits(getMember, result, field);
			alias FieldT = typeof(Field);
			static if (is(FieldT == Mutation)) {
				Mutation mutation;
				JSONValue json = value["mutation"];
				mutation.proccode = json["proccode"].get!string;
				mutation.argumentids = json["argumentids"].get!string;
				if ("argumentnames" in json) {
					mutation.argumentnames = json["argumentnames"].get!string;
				}
				__traits(getMember, result, field) = mutation;
			}
			else static if (field == "inputs") {}
			else {
				string inputName;
				static if (hasUDA!(Field, Input)) {
					inputName = getUDAs!(Field, Input)[0].name;
				}
				else {
					inputName = field.map!toUpper.to!string;
				}
				static if (hasUDA!(Field, ScratchField)) {
					auto fieldValue = value["fields"][inputName];
					static if (is(FieldT == string)) {
						__traits(getMember, result, field) = fieldValue.array[0].get!string;
					}
					else {
						__traits(getMember, result, field) = fieldValue.array
							.map!(x => x.get!string).array
							.to!(string[2]);
					}
				}
				else {
					if (inputName in inputs) {
						Block inputBlock = inputs[inputName];

						static if (is(FieldT == Block)) {
							__traits(getMember, result, field) = inputBlock;
						}
						else static if (is(FieldT == ReporterBlock)) {
							auto block = cast(ReporterBlock) inputBlock;
							enforce(block, new Exception(inputBlock.toString));
							__traits(getMember, result, field) = block;
						}
						else static if (is(FieldT == StackBlock[])) {
							enforce(cast(StackBlock) inputBlock);
							__traits(getMember, result, field) = readStack(inputBlock.blockId);
						}
						else {
							static assert(0, "can't deserialize field of type " ~ FieldT.stringof);
						}
					}
					else {
						static if (is(FieldT == ReporterBlock)) {
							auto block = new LiteralBlock;
							block.parent = this;
							block.value = "";
							__traits(getMember, result, field) = block;
						}
						else static if (is(FieldT == StackBlock[])) {
						}
						else {
							enforce(0);
						}
					}
				}
			}
		}}
		static if (is(T : HatBlock)) {
			if (!value["next"].isNull) {
				result.children = readStack(value["next"].get!string);
			}
		}
		return result;
	}

	StackBlock[] readStack(string id) {
		StackBlock[] result;
		while (true) {
			auto data = getBlockJson(id);
			auto block = cast(StackBlock) readBlock(id);
			enforce(block);
			result ~= block;
			if (data["next"].isNull) {
				break;
			}
			else {
				id = data["next"].get!string;
			}
		}
		return result;
	}

	JSONValue getBlockJson(string id) {
		return project.project["targets"][index]["blocks"][id];
	}

public:

	Block readBlock(string id) {
		import std.algorithm : canFind;

		if (id in blocks) {
			return blocks[id];
		}

		JSONValue value = getBlockJson(id);
		string opcode = value["opcode"].get!string;
		if (recognizedOpcodes.canFind(opcode)) {
			import std.traits : getSymbolsByUDA;

			static foreach (i, v; recognizedOpcodes) {
				if (opcode == v) {
					auto result = deserializeBlock!(getSymbolsByUDA!(
						scratch, BlockSerialize)[i])(id, value);
					blocks[id] = result;
					return result;
				}
			}
			assert(0);
		}
		else {
			throw new Exception("unrecognized opcode '" ~ opcode ~ "'");
		}
		assert(0);
	}
}

final class ScratchProject {

	private JSONValue project;

	Sprite[] sprites;
	Sprite stage;

	private size_t[string] varCount;
	private size_t[string] spriteCount;

	string[string] varMap;
	string[] spriteMap;

	this(string file) {
		import std.zip : ZipArchive, ArchiveMember;
		import std.file : read;

		auto archive = new ZipArchive(read(file));
		foreach (name, member; archive.directory) {
			if (name == "project.json") {
				import std.json : parseJSON;

				ubyte[] data = archive.expand(member);
				project = parseJSON(cast(char[]) data);
			}
		}

		if (project.isNull) {
			throw new Exception("invalid project file");
		}

		auto targets = project["targets"].array;
		foreach (i, v; targets) {
			import java : camelize;

			auto sprite = new Sprite;
			string spriteName = v["name"].get!string;
			string uniqueSpriteName = camelize(spriteName);
			if (uniqueSpriteName in spriteCount) {
				import std.conv : to;

				uniqueSpriteName ~= "_" ~ spriteCount[uniqueSpriteName].to!string;
				spriteCount[uniqueSpriteName] += 1;
			}
			else {
				spriteCount[uniqueSpriteName] = 1;
			}
			spriteMap ~= uniqueSpriteName;
			sprite.name = spriteName;
			sprite.uniqueName = uniqueSpriteName;
			sprite.index = i;
			sprite.project = this;
			if (v["isStage"].get!bool) {
				enforce(!stage, new Exception("multiple stages"));
				stage = sprite;
			}
			foreach (key; v["blocks"].object.byKey) {
				sprite.readBlock(key);
			}
			foreach (key, value; v["variables"].object) {
				string name = value[0].get!string;
				string uniqueName = camelize(name);
				if (uniqueName in varCount) {
					import std.conv : to;

					uniqueName ~= "_" ~ varCount[uniqueName].to!string;
					varCount[uniqueName] += 1;
				}
				else {
					varCount[uniqueName] = 1;
				}
				varMap[key] = uniqueName;
				string initValue;
				if (value[1].type == JSONType.string) {
					initValue = value[1].get!string;
				}
				else {
					initValue = value[1].toString;
				}
				sprite.vars ~= Variable(
					key,
					name,
					uniqueName,
					initValue,
				);
			}
			foreach (key, value; v["lists"].object) {
				import std.algorithm : map;
				import std.array : array;

				string name = value[0].get!string;
				string uniqueName = camelize(name);
				if (uniqueName in varCount) {
					import std.conv : to;

					uniqueName ~= "_" ~ varCount[uniqueName].to!string;
					varCount[uniqueName] += 1;
				}
				else {
					varCount[uniqueName] = 1;
				}
				varMap[key] = uniqueName;
				string[] initValue = value[1].array.map!(x => x.get!string).array;
				sprite.lists ~= List(
					key,
					name,
					uniqueName,
					initValue,
				);
			}
			sprites ~= sprite;
		}
	}

}
