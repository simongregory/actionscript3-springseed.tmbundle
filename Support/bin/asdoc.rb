#!/usr/bin/env ruby -wKU

require "rexml/document"
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH'] + "/lib/web_preview"

HELP_DICT = ENV['TM_BUNDLE_SUPPORT'] + '/data/doc_dictionary.xml'

WORD = STDIN.read.strip

framework = "Springseed"
framework_home = "TM_SPRINGSEED_HOME"

TextMate.exit_show_tool_tip( "#{framework_home} Not Defined.") if ENV[framework_home] == nil

manual_path = ENV[framework_home] + "/asdoc/#{framework.downcase}"
manual_uri = "tm-file://"+ manual_path

TextMate.exit_show_tool_tip( "#{framework_home} 404" + manual_path ) unless File.exists?( manual_path )

if WORD.empty?
    
    puts html_head( :title => "Error", :sub_title => "#{framework} Documentation" )
    puts "<h1>Please specify a search term.</h1>"
    html_footer
    TextMate.exit_show_html

end

puts html_head( :title => "#{framework} Documentation Search", :sub_title => "#{framework} Framework" )
puts "<h1>Results for ‘#{WORD}’</h1><p>"

# Open the HELP_DICT xml file and
# collect matching results.
search_results = [];
class_doc = REXML::Document.new File.new(HELP_DICT)
class_doc.elements.each( "dict/a" ) do |tag|

    e = tag[0].to_s
    if e[/#{WORD}/i]
        href = tag.attributes["href"]
        tag.attributes["href"] = manual_uri + "/" + href;
        tag.attributes["title"] = href.gsub( "/", ".").sub( ".html", "");
        search_results.push( tag )
    end
    
end

if search_results.size == 1

    puts "<meta http-equiv=\"refresh\" content=\"1; #{search_results[0].attributes['href']}\">"
    puts "<ul><li>#{WORD} Found, redirecting..</li></ul></p>"
       
elsif search_results.size > 0
    
    puts "<p><ul>"
    search_results.each { |tag| puts "<li>" + tag.to_s + "</li>" }
    puts "</ul></p>"    

else

   puts "<ul><li>No results.</li></ul></p>"

end

puts "<a href='" + manual_uri + "/index.html' title='#{framework} AsDocs'>#{framework} Documentation</a>"

html_footer
TextMate.exit_show_html
