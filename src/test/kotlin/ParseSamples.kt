import org.junit.Test
import java.io.File
import java.io.FileInputStream
import com.quantdsl.quantdslLexer
import com.quantdsl.quantdslParser
import org.antlr.v4.runtime.*
import org.antlr.v4.runtime.atn.ATNConfigSet
import org.antlr.v4.runtime.dfa.DFA
import java.util.*
import kotlin.test.assertTrue

class ParseSamples {

    private fun tryToParse(file: File) : quantdslParser.QuantProgramContext {
        val ais = ANTLRInputStream(FileInputStream(file))
        val lexer = quantdslLexer(ais)
        val errors = LinkedList<String>()
        lexer.removeErrorListeners()
        lexer.addErrorListener(object : ANTLRErrorListener {
            override fun reportAttemptingFullContext(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, conflictingAlts: BitSet?, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun syntaxError(recognizer: Recognizer<*, *>?, offendingSymbol: Any?, line: Int, charPositionInLine: Int, msg: String?, e: RecognitionException?) {
                errors.add("Error in example at line $line, col $charPositionInLine: $msg")
            }

            override fun reportAmbiguity(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, exact: Boolean, ambigAlts: BitSet?, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun reportContextSensitivity(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, prediction: Int, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }
        })
        val parser = quantdslParser(CommonTokenStream(lexer))
        parser.removeErrorListeners()
        parser.addErrorListener(object : ANTLRErrorListener {
            override fun reportAttemptingFullContext(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, conflictingAlts: BitSet?, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun syntaxError(recognizer: Recognizer<*, *>?, offendingSymbol: Any?, line: Int, charPositionInLine: Int, msg: String?, e: RecognitionException?) {
                errors.add("Error in example at line $line, col $charPositionInLine: $msg")
            }

            override fun reportAmbiguity(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, exact: Boolean, ambigAlts: BitSet?, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun reportContextSensitivity(recognizer: Parser?, dfa: DFA?, startIndex: Int, stopIndex: Int, prediction: Int, configs: ATNConfigSet?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }
        })
        val ast = parser.quantProgram()
        errors.forEach {
            System.err.println(it)
        }
        assertTrue(errors.isEmpty())
        return ast
    }

    @Test
    fun parseSample() {
        tryToParse(File("examples/sample.qdsl"))
    }

    @Test
    fun parseOnlyComments() {
        tryToParse(File("src/test/resources/justcomments.qdsl"))
    }

}