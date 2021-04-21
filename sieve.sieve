require [ "variables", "regex", "fileinto", "envelope", "date", "mailbox", "imap4flags" ];


if header :matches "X-Mailer" "MailChimp Mailer" {
  fileinto "INBOX.newsletters";
} elsif anyof ( exists "X-Campaign",
           exists "X-binding",
           exists "X-MarketoID"
          ) {
# junk Could be marketing lists....
  fileinto "INBOX.junk";
  stop;
} elsif anyof ( address :is :localpart "from" "no-reply",
                address :is :localpart "from" "noreply",
                address :is :localpart "from" "do-not-reply",
                address :is :localpart "from" "donotreply",
                address :is :localpart "from" "donotreply"
              ) {
  if header :contains [ "subject" ] [ "verify * email", "confirm * email", "[rR]eset" ] {
    addflag "accounts";
    stop;
  } else {
    setflag "robot";
    stop;
  }
} elsif allof ( exists "X-Mailman-Version",
                exists "X-BeenThere",
                not exists "X-Campaign",
                exists "List-Post" ) {
# Mailman lists
  #if header :contains "X-BeenThere" "*@*.*" {

  if header :regex "List-I[dD]" "<([^\.])+." { set :lower "mailingID" "${1}"; }
  if header :contains "X-BeenThere" "*@*.*" {
# # Subject: [acme-users] [fwd] version 1.0 is out
# if header :matches "Subject" "[*] *" {
# ${1} will hold "acme-users",
# ${2} will hold "[fwd] version 1.0 is out"
    set :lower "listname" "${1}";
    addflag "listName-${2}";
    fileinto "Lists.${listname}";
    stop;
  } elsif string ["nanog", "ietf", "novalug", "kernel", "abacus"] "${mailID}" {
    addflag "listId-${mailID}";
    fileinto "Lists.${mailID}";
    stop;
  } elsif header :matches "List-[pP]" "<mailto:*@*" {
    set :lower "listname" "${2}";
    addflag "listMailto-${2}";
    fileinto :create "Lists.${listname}";
    stop;
  } else {
    addflag "listElse-${mailingID}";
    fileinto :create "Lists.unknown";
  }
} elsif exists "List-Unsubscribe" {
  if not exists [ "List-Post", "List-Help" ] {
    fileinto "INBOX.junk";
  }
}
