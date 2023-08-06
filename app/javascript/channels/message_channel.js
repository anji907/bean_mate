import consumer from "./consumer"

const roomId = document.getElementById('room-id').value;

const appMessage = consumer.subscriptions.create({ channel: "MessageChannel", room_id: roomId }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const userData = document.getElementById('user-data');
    const userId = userData.getAttribute('data-user-id');

    console.log(data);

    if (userId == data['user_id']) {
      // DOM作成
      let outerDiv = document.createElement('div');
      outerDiv.className = 'message-right';

      let innerDiv = document.createElement('div');
      innerDiv.className = 'message-content';

      let p = document.createElement('p');
      p.textContent = data['message'];

      // DOMを挿入
      outerDiv.prepend(innerDiv);
      innerDiv.prepend(p);

      console.log(outerDiv);

      const messages = document.getElementById('messages');
      messages.append(outerDiv);
    } else {
      console.log('他のユーザーのメッセージです');

      // dom作成
      let div = document.createElement('div');
      div.setAttribute('class', 'message-left');

      let picDiv = document.createElement('div');
      div.setAttribute('class', 'pic');

      let img = document.createElement('img');
      img.setAttribute('src', data['avatar_url']);
      img.setAttribute('class', 'rounded-circle mr15');
      img.height = 40;
      img.width = 40;
      picDiv.append(img);

      // span for nickname
      let span = document.createElement('span');
      span.setAttribute('class', 'user-nickname');
      span.textContent = data['user'];
      div.append(span);

      // div for message
      let div2 = document.createElement('div');
      div2.setAttribute('class', 'message-content');
      div.append(div2);

      let p = document.createElement('p');
      p.textContent = data['message'];
      div2.append(p);

      const messages = document.getElementById('messages');
      messages.append(div);
    }
  },

  speak: function(data) {
    return this.perform('speak', data);
  }
});

// 送信ボタンのdomを取得
const submitButton = document.getElementById('js-submit-btn');
submitButton.addEventListener('click', function(e) {
  const input = document.getElementById('js-content');
  const message = input.value;
  const roomId = document.getElementById('room-id').value;
  appMessage.speak({ message: message, room_id: roomId });
  input.value = '';
  e.preventDefault();
});