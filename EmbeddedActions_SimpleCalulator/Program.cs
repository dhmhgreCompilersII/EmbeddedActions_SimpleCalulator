using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;


namespace EmbeddedActions_SimpleCalulator {
    class Program {
        static void Main(string[] args) {
            /*StreamReader a = new StreamReader(args[0]);
            AntlrInputStream antlrInput =new AntlrInputStream(a);
            EACalcLexer lexer = new EACalcLexer(antlrInput);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            EACalcParser parser = new EACalcParser(tokens);
            IParseTree tree = parser.compileUnit();*/
            string expr = Console.ReadLine();
            int line = 0;


            EACalcParser parser = new EACalcParser(null);
            parser.BuildParseTree = false;

            while (true) {
                AntlrInputStream input =new AntlrInputStream(expr);
                EACalcLexer lexer = new EACalcLexer(input);
                lexer.Line = line;
                lexer.Column = 0;
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                parser.SetInputStream(tokens);
                parser.compileUnit();
                expr = Console.ReadLine();
                line++;
            }

        }
    }
}
