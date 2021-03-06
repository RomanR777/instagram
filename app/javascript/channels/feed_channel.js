import consumer from "./consumer"

consumer.subscriptions.create("FeedChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Channel connected...')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log("Recieving:")
      console.log(data.content)
      $.get('/posts/' + data.content['post_id'] + '/followee');
   }

});
