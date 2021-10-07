import java.util.regex.*

if (args.length <= 0) {
    System.err.println("usage groovy build/update.groovy version")
    System.exit(1)
}

String version = args[0]

String packageUrl = "https://packages.scm-manager.org/repository/releases/sonia/scm/packaging/unix/${version}/unix-${version}.tar.gz"
String checksum = new URL(packageUrl + ".sha256").text

def urlPattern = Pattern.compile('^(\s+url\s+)"(.*)"$')
def checksumPattern = Pattern.compile('^(\s+sha256\s+)"(.*)"$')

def lines = [];

def file = new File("Formula/scm-server.rb")
file.eachLine { line ->
   def m = urlPattern.matcher(line)
   if (m.matches()) {
       lines.add(m.replaceFirst('$1"' + packageUrl + '"'))

   } else {
       m = checksumPattern.matcher(line)
       if (m.matches()) {
           lines.add(m.replaceFirst('$1"' + checksum + '"'))
       } else {
           lines.add(line)
       }
   }
}

file.write lines.join('\n') + '\n'
