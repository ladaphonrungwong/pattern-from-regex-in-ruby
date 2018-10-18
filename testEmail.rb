fh = File.open("test_emails.txt","r")

s1 = ""
for line in fh
  s1 = s1+line
end

fh.close()

contents = s1.split("From r")

#contents.pop(0) ใช้ shift ดึงตัวแรก ใช้ pop ดึงตัวล่าสุด
#To retrieve and at the same time remove the first item, use shift:
contents.shift
#print contents

emails = []

for item in contents

    emails_dict = {}

    sender = item.match /From:.*/
    sender = sender.to_s


    if (sender != nil)
        s_email = sender.match /\w\S*@.*\w/
        s_name  = sender.match /:.*</
    else
        s_email = nil
        s_name = nil
    end



    if s_email != nil
        sender_email = s_email.to_s
    else
        sender_email = nil
    end
    emails_dict["sender_email"] = sender_email



    if s_name != nil
        s_name = s_name.to_s
        sender_name = s_name.gsub(/\s*</,"").gsub(/:\s*/, "")
    else
        sender_name = nil
    end

    emails_dict["sender_name"] = sender_name



    recipient = item.match /To:.*/
    recipient = recipient.to_s


    if recipient != nil
        r_email = recipient.match /\w\S*@.*\w/
        r_name = recipient.match /:.*</
    else
        r_email = nil
        r_name = nil
    end

    if r_email != nil
        recipient_email = r_email.to_s
    else
        recipient_email = nil
    end

    emails_dict["recipient_email"] = recipient_email


    if r_name != nil
        recipient_name = r_name.gsub(/\s*</, "").gsub(/:\s*/, "")
    else
        recipient_name = nil
    end
    emails_dict["recipient_name"] = recipient_name


    date_field = item.match /Date:.*/
    date_field = date_field.to_s


    if date_field != nil
        date = date_field.match /\d+\s\w+\s\d+/

    else
        date = nil
    end

    if date != nil
        date_sent = date.to_s

    else
        date_sent = nil
    end

    emails_dict["date_sent"] = date_sent



    subject_field = item.match /Subject: .*/
    subject_field = subject_field.to_s

    if subject_field != nil
        subject = subject_field.gsub(/Subject: /, "")

    else
        subject = nil
    end

    emails_dict["subject"] = subject

    full_email = item.match /Status:.*/m
    #puts full_email
    #puts "------------------------------------"
    emails_dict["email_body"] = "email body here"

    emails.push(emails_dict)


end

puts("Number of emails: " + emails.length.to_s )
puts


#for key, value in emails[0]
(0..(emails.length-1)).each do |i|
  puts "Email No :#{i+1}"
  for key, value in emails[i]
    puts(key.to_s + ": " + emails[i][key].to_s)
  end

  puts "\n\n"

end
