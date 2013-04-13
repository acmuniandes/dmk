//
// publish to
//
function streamPublish(name, description, hrefTitle, hrefLink, userPrompt){
    FB.ui(
        {
            method: 'stream.publish',
            message: '',
            attachment: {
                name: name,
                caption: '',
                description: (description),
                href: hrefLink
            },
            action_links: [
                { text: hrefTitle, href: hrefLink }
            ],
            user_prompt_message: userPrompt
        },
        function(response) {

        });
}
