<not-found>
  <h3>Not sure what you're looking for ... but it's not here!</h3>
  <h3>Sending you back to the login ... </h3>

  <script>
  /* Sends you to login after 3 seconds */
  this.on('mount', () => {
      setTimeout(()=>{
        window.location = "#/login";
          }, 3000);
      })
  </scrip>
</not-found>
