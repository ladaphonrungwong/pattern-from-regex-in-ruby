fh = File.readlines('test_emails.txt')
#fh = File.readlines('fradulent_emails.txt')

s1 = fh.join("")

contents = s1.split("From r")

s2 = File.readlines('countries-list.txt')
s2 = s2.join("")
countriesList = s2.split("\n")

contents.shift
emails = []

for item in contents
    emails_dict = {}

    s_email = s_name = r_email = r_name = date = subject_field = full_email = nil
    dollar = percent = cl_name = nil

    sender = (item.match /From:.*/).to_s
    if (sender)
        s_email = (sender.match /\w\S*@.*\w/).to_s
        s_name  = (sender.match /:.*</).to_s

    end

    emails_dict["sender_email"] = s_email if s_email != ""
    emails_dict["sender_name"] = s_name.gsub(/\s*</,"").gsub(/:\s*/, "").gsub(/\"/, "") if s_name != ""


    recipient = (item.scan /To:.*/).to_s

    #recipient = (item.match /(?<!Reply-)To:.*/).to_s

    #(str =~ /(?<!a)o/).to_s found n_b : o หลัง a negative



    if recipient
        r_email = (recipient.match /\w\S*@.*\w/).to_s
        r_name = (recipient.match /:.*</).to_s
    end
    puts r_name
    emails_dict["recipient_email"] = r_email if r_email != ""
    emails_dict["recipient_name"] = r_name.gsub(/\s*</, "").gsub(/:\s*/, "").gsub(/\"/, "") if r_name != ""
    #puts r_name.is_a?(String)

    date_field = (item.match /Date:.*/).to_s
    date = (date_field.match /\d+\s\w+\s\d+/).to_s if date_field != ""
    emails_dict["date_sent"] = date if date != ""

    subject_field = (item.match /Subject: .*/).to_s
    emails_dict["subject"] = subject_field.gsub(/Subject: /, "") if subject_field != ""


    full_email = item.match /Status:.*/m


    #scan returns everything that the Regex matches.
    #match returns the first match as a MatchData object

    dollar = (full_email.to_s.scan /\w+[$]\w+/m).to_s if full_email != ""

    emails_dict["dollar"] = dollar if dollar != ""

    percent = (full_email.to_s.scan /\d+[%]/m).to_s if full_email != ""

    emails_dict["percent"] = percent if percent != ""

    cl_name = []
    for cl in countriesList
      #puts cl
      countries = (full_email.to_s.scan /#{cl}/im) if full_email != ""
      #ZIMBABWE
      #countries = full_email.to_s.scan /ZIMBABWE/m if full_email
      #puts cl_name
      cl_name += countries if countries  != ""

    end
    #puts cl_name
    cl_name = cl_name.uniq
    emails_dict["countries"] = cl_name if cl_name != ""


    #emails_dict["email_body"] = full_email if full_email
    #emails_dict["email_body"] = "email_body"

    emails.push(emails_dict)
end




puts("Number of emails: " + (emails.length).to_s)
puts "\n"

#begin
for index in (0..emails.length-1)
  puts "Email No : " + (index+1).to_s
  for key, value in emails[index]
    puts(key.to_s + ": " + value.to_s)
  end
  puts "\n"
end
#=end

# puts ""
# puts emails.map {|x| x.values[8]}.uniq
