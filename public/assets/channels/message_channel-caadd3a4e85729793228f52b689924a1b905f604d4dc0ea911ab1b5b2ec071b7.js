import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('beforeend', data['message']);
    document.getElementById('js-content').value = '';
    scrollToBottom();
  }
});

const scrollToBottom = () => {
  const messageArea = document.getElementById('messages');
  messageArea.scrollTop = messageArea.scrollHeight;
};

window.addEventListener('DOMContentLoaded', scrollToBottom);
