require_relative '../config/environment'



thing = Crack::XML.parse(<<-XML)
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<companies total="2">
  <company>
   <id>162479</id>
   <name>Apple Inc.</name>
  </company>
  <company>
   <id>1276</id>
   <name>Apple Retail</name>
  </company>
</companies>
XML

p thing