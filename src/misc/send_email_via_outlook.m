function send_email_via_outlook(to, subject, body, attachments)
% SEND_EMAIL_VIA_OUTLOOK Send an email using Outlook
%
%   SEND_EMAIL_VIA_OUTLOOK(TO, SUBJECT, BODY) sends an email to the
%   specified address with the specified subject and body. The body may
%   contain HTML tags.
%
%   SEND_EMAIL_VIA_OUTLOOK(_, ATTACHMENTS) also attaches the specified
%   filed to the email. The ATTACHMENTS must be a string array with full
%   *absolute* paths to the files.
%
%   The implementation is taken from here
%   https://www.mathworks.com/matlabcentral/answers/94446-can-i-send-e-mail-through-matlab-using-microsoft-outlook

arguments
    to {mustBeTextScalar}
    subject {mustBeTextScalar}
    body {mustBeTextScalar}
    attachments (1,:) {mustBeText} = string([]);
end

h = actxserver('outlook.Application');

mail = h.CreateItem('olMail');
mail.Subject = subject;
mail.To = to;
mail.BodyFormat = 'olFormatHTML';
mail.HTMLBody = body;

% Add attachments, if specified.
if ~isempty(attachments)
    for i = 1:length(attachments)
        mail.attachments.Add(attachments(i));
    end
end

% Send message and release object.
mail.Send;
h.release;

end
