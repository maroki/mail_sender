class CustomMailer < ApplicationMailer
  def compose(template, user)
    m = mail(to: user.email,
         subject: template.subject,
         from: template.game.send_from) do |format|
      format.text { render text: template.text.html_safe }
      format.html { render text: template.text.html_safe }
    end
    m
  end
end
