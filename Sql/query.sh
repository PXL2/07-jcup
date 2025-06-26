
INPUT_FILE="entradaquery.txt"


echo "Limpando arquivos gerados..."
rm -f *.class *.java sym.java QueryParser.java QueryLexer.java
rm -f jcup.jar jflex.jar
echo "Baixando JFlex e CUP JARs..."
wget -q https://repo1.maven.org/maven2/de/jflex/jflex/1.8.2/jflex-1.8.2.jar -O jflex.jar
wget -q https://repo1.maven.org/maven2/com/github/vbmacher/java-cup/11b-20160615/java-cup-11b-20160615.jar -O jcup.jar
echo "Gerando QueryLexer.java com JFlex..."
java -cp "jflex.jar:jcup.jar" jflex.Main QueryLexer.flex
echo "Gerando QueryParser.java e sym.java com CUP..."
java -cp jcup.jar java_cup.Main -parser MeuParser QueryParser.cup
echo "Compilando arquivos Java gerados..."
javac -cp ".:jflex.jar:jcup.jar" *.java
echo -e "\n--- Executando analisador de Consulta ---"
java -cp ".:jflex.jar:jcup.jar" MeuParser "$INPUT_FILE"
if [ $? -eq 0 ]; then
    echo "Análise de consulta concluída com sucesso."
else
    echo "Análise de consulta falhou."
fi