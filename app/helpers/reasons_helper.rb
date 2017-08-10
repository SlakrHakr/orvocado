module ReasonsHelper
  def link_urls input
      output = ''
      input.split('<br/>').each do |line|
        line.split(' ').each do |word|
          escaped = word
          escaped = escaped.gsub(/( |^)(http|https):\/\/([^\s]*\.[^\s]*)( |$)/){ "<a href='#{$2}://#{$3}'>#{$2}://#{$3}</a>" }
          escaped = escaped.gsub(/( |^)\[(.*)\|(http|https):\/\/([^\s]*\.[^\s]*)\]( |$)/){ "<a href='#{$3}://#{$4}'>#{$2}</a>" }

          output += escaped
          output += ' '
        end
        output += '<br/>'
      end
      output
  end
end
