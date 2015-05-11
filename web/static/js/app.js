import {Socket} from "phoenix"
  
let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

let socket = new Socket("/ws")
let repo = {bacon: 'eggs', pancakes: 'syrup'}

socket.connect()
socket.join("rooms:lobby", {}).receive("ok", chan => {
  console.log("Welcome to Phoenix Chat!")

  chatInput.off("keypress").on("keypress", event => {
    if(event.keyCode === 13){
      chan.push("new_msg", {body: chatInput.val()})
      chatInput.val("")
    }
    if(event.keyCode === 96){
      chan.push("read", {body: chatInput.val()})
      chatInput.val("")
      event.preventDefault(0)
    }
  })

  chan.on("new_msg", payload => {
    messagesContainer.append(`</br> ${payload.body}`)
  })

  chan.on("read", payload => {
    chan.push("new_msg", {body: repo[`${payload.body}`]})
  })
})
