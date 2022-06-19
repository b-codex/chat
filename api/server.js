const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const log = console.log;

const messages = [];

io.on('connection', (socket) => {
  const id = socket.id;
  const senderID = socket.handshake.query.senderID;
  // log('\nUsername: ', senderID, '\nID: ', id, '\n');
  log('User: ', senderID, ' Connected');
  io.emit('messages', messages);
  socket.on('message', (data) => {
    const message = {
      'message': data.message,
      'senderID': senderID,
      'sentAt': Date.now(),
    }
    messages.push(message);

    // log(messages);

    // log('\nMessage: ', data.message, '\nID: ', id, '\nUsername: ', senderID, '\n');

    io.emit('message', message);

    // io.emit('chat message', {
    //   id,
    //   senderID,
    //   msg
    // });
  });
});

server.listen(3000, () => {
  log('listening on *:3000');
});