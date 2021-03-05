require [ "variables", "fileinto", "mailbox", "imap4flags" ];
if anyof ( exists "X-Campaign",
exists "X-binding",
exists "X-MarketoID"
)
{
# junk Could be marketing lists....
fileinto "INBOX.junk";
stop;
} elsif  header :matches "X-Mailer" "MailChimp Mailer"
{
fileinto "INBOX.newsletters";
} elsif anyof ( address :is :localpart "from" "no-reply",
address :is :localpart "from" "noreply",
address :is :localpart "from" "do-not-reply",
address :is :localpart "from" "donotreply",
address :is :localpart "from" "donotreply"
)
{
if header :contains "subject" [ "verify * email", "confirm * email", "[rR]eset" ]
{
addflag "accounts";
stop;
}
else
{
fileinto "robots";
stop;
}
} elsif allof ( exists "X-Mailman-Version",
exists "X-BeenThere",
not exists "X-Campaign",
exists "List-Post" )
{
# Mailman lists
if header :contains "X-BeenThere" "*@*.*"
# # Subject: [acme-users] [fwd] version 1.0 is out
# if header :matches "Subject" "[*] *" {
# ${1} will hold "acme-users",
# ${2} will hold "[fwd] version 1.0 is out"
{
set :lower "listname" "${1}";
fileinto "Lists.${listname}";
stop;
}
# Could be marketing lists....
elsif header :matches "List-I[dD]" "*<*@*"
{

set :lower "listname" "${2}";
fileinto "Lists.${listname}";
stop;
}
elsif header :matches "List-[pP]" "<mailto:*@*"
{
set :lower "listname" "${2}";
fileinto :create "Lists.${listname}";
stop;
}
else
{
fileinto :create "Lists.unknown";
}
}
elsif exists "List-Unsubscribe"
{
if not exists [ "List-Post", "List-Help" ]
{
fileinto "INBOX.junk";
}
}
