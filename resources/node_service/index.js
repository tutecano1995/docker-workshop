const express = require('express');

const app = express();

app.get('/ping', (req, res) => res.send('Pong!'));

app.listen(8022, () => {
    console.log('App running on port 8022'); 
});

