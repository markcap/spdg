require "open-uri"

pdf.image open("http://spdgkansas.net/images/spdg_logo_new.jpg"), :width => 80, :height => 65, :position => -40
pdf.text @survey.name + " Survey", :size => 20, :align => :center
pdf.text nice_date(@survey.ends_on), :align => :center
pdf.move_down(40)

@survey.questions.each do |q|
  pdf.text q.content, :style => :bold
  pdf.move_down(15)
  if q.answer.content.nil? || q.answer.content.blank?
    pdf.text "No Answer."
  else
    pdf.text q.answer.content
  end
  pdf.move_down(30)
end