(function ($){
  var contestants = { names : []};
  var winners = { names : []};
  var winner;



  // Helpers
  var blackHex = '#333',
      whiteHex = '#fff',
      shuffle = function(o) {
          for ( var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x)
              ;
          return o;
      },
      halfPI = Math.PI / 2,
      doublePI = Math.PI * 2;

	String.prototype.hashCode = function(){
		// See http://www.cse.yorku.ca/~oz/hash.html
		var hash = 5381,
            i;
		for (i = 0; i < this.length; i++) {
			char = this.charCodeAt(i);
			hash = ((hash<<5)+hash) + char;
			hash = hash & hash; // Convert to 32bit integer
		}
		return hash;
	};

	Number.prototype.mod = function(n) {
		return ((this%n)+n)%n;
    };

// WHEEL!
	var wheel = {
		timerHandle : 0,
		timerDelay : 23,

		angleCurrent : 0,
		angleDelta : 0,

		size : 290,

		canvasContext : null,


    colors : [ '#FE2E2E', '#DF0101', '#8A0808', '#B40431' ],

		segments : [],

		seg_colors : [], // Cache of segments to colors

		maxSpeed : Math.PI / 16,

		upTime : 5000, // How long to spin up for (in ms)
		downTime : 10000, // How long to slow down for (in ms)

		spinStart : 0,


		frames : 0,
    progress : 0,

		centerX : 300,
		centerY : 300,

		spin : function() {
			// Start the wheel only if it's not already spinning
			if (wheel.timerHandle == 0) {
				wheel.spinStart = new Date().getTime();
				wheel.maxSpeed = Math.PI / (16 + Math.random()); // Randomly vary how hard the spin is
				wheel.frames = 0;
        wheel.progress = 0;
				wheel.timerHandle = setInterval(wheel.onTimerTick, wheel.timerDelay);
			}
		},
		onTimerTick : function() {

      var duration = (new Date().getTime() - wheel.spinStart),
          finished = false;

			wheel.frames++;
			wheel.draw();

      soundManager.createSound({
        id: 'tick',
        url: '/audio/spoke.mp3',
        autoLoad: true,
        autoPlay: true,
        volume: 30
      })

			if (duration < wheel.upTime) {
				wheel.progress = duration / wheel.upTime;
				wheel.angleDelta = wheel.maxSpeed
						* Math.sin(wheel.progress * halfPI);
			} else {
				wheel.progress = duration / wheel.downTime;
				wheel.angleDelta = wheel.maxSpeed
						* Math.sin(wheel.progress * halfPI + halfPI);
                if(jQuery.inArray(winner, winners.names) != -1) {
                    console.log("is in array");

                } else {
                    console.log("is NOT in array");
                }
                if (wheel.progress >= 1 && jQuery.inArray(winner, winners.names) !== -1){
                    finished = true;
                    soundManager.stop('tick');

                    //remove winner from winners array
                    console.log(winner);
                    console.log(winners.names);
                    var index = winners.names.indexOf(winner);
                    winners.names.splice(index, 1);
                    console.log(winners.names);

                } else {
                    wheel.progress = 0;
                    wheel.angleDelta = 0.1;
                }
			}

			wheel.angleCurrent += wheel.angleDelta;
            while (wheel.angleCurrent >= doublePI){
				// Keep the angle in a reasonable range
				wheel.angleCurrent -= doublePI;
            }
			if (finished) {
				clearInterval(wheel.timerHandle);
        wheel.angleDelta = 0;
        $('#winners').append('<li style="display:none" id="' + winner.replace(/[^A-Z0-9]+/ig, "_") + '">' + winner + '</li>')
        $("#" + winner.replace(/[^A-Z0-9]+/ig, "_")).fadeIn(3000, function() {
          if (winners.names.length > 0) {
            wheel.spinStart = new Date().getTime();
            wheel.maxSpeed = Math.PI / (16 + Math.random()); // Randomly vary how hard the spin is
            wheel.frames = 0;
            wheel.progress = 0;
            wheel.timerHandle = setInterval(wheel.onTimerTick, wheel.timerDelay);
            soundManager.play('tick');
            } else {


              soundManager.createSound({
                id: 'theme',
                url: '/audio/theme.mp3',
                autoLoad: true,
                autoPlay: true,
                volume: 50
              });

              $('.firework').show();
              $('#spins').html("0");
              wheel.timerHandle = 0;
              function blinker() {
                  $('.blink_me').fadeOut(1500);
                  $('.blink_me').fadeIn(1500);
              }

              setInterval(blinker, 1000); //Runs every second
            }
          });
        if (console){ console.log((wheel.frames / duration * 1000) + " FPS"); }
			};

			/*
			// Display RPM
			var rpm = (wheel.angleDelta * (1000 / wheel.timerDelay) * 60) / (Math.PI * 2);
			$("#counter").html( Math.round(rpm) + " RPM" );
			 */
		},



		init : function(optionList) {
			try {
				wheel.initWheel();
				wheel.initCanvas();
				wheel.draw();

				$.extend(wheel, optionList);

			} catch (exceptionData) {
				alert('Wheel is not loaded ' + exceptionData);
			}

		},


		initCanvas : function() {
			var canvas = $('#wheel-canvas')[0];
			canvas.addEventListener("click", wheel.spin, false);
			wheel.canvasContext = canvas.getContext("2d");
		},

		initWheel : function() {
			shuffle(wheel.colors);
		},

		// Called when segments have changed
		update : function() {
			// Ensure we start mid way on a item
			//var r = Math.floor(Math.random() * wheel.segments.length);
			var r = 0,
                segments = wheel.segments,
			    len      = segments.length,
                colors   = wheel.colors,
			    colorLen = colors.length,
                seg_color = [], // Generate a color cache (so we have consistant coloring)
                i
            wheel.angleCurrent = ((r + 0.5) / wheel.segments.length) * doublePI;

            for (i = 0; i < len; i++){
				seg_color.push( colors [ segments[i].hashCode().mod(colorLen) ] );
            }
			wheel.seg_color = seg_color;

			wheel.draw();

		},

		draw : function() {
			wheel.clear();
			wheel.drawWheel();

      wheel.drawNeedle();
      $('#spins').html(winners.names.length);

		},

		clear : function() {
			wheel.canvasContext.clearRect(0, 0, 1000, 800);
		},


		 drawNeedle : function() {
		 	var ctx = wheel.canvasContext,
                 centerX = wheel.centerX,
                 centerY = wheel.centerY,
                 size = wheel.size,
                 i,
                 centerSize = centerX + size,
                 len = wheel.segments.length;
		 	ctx.lineWidth = 2;
		 	ctx.strokeStyle = blackHex;
		 	ctx.fillStyle = whiteHex;

		 	ctx.beginPath();

		 	ctx.moveTo(centerSize - 10, centerY);
		 	ctx.lineTo(centerSize + 10, centerY - 10);
		 	ctx.lineTo(centerSize + 10, centerY + 10);
		 	ctx.closePath();

		 	ctx.stroke();
		 	ctx.fill();

		 	// Which segment is being pointed to?
		 	i = len - Math.floor((wheel.angleCurrent / doublePI) * len) - 1;


		 	// Now draw the winning name
		 	ctx.textAlign = "left";
		 	ctx.textBaseline = "middle";
		 	ctx.fillStyle = blackHex;
		 	ctx.font = "1.5em Arial";
      winner = wheel.segments[i];
		 	ctx.fillText(winner, centerSize + 20, centerY);
		 },


		drawSegment : function(key, lastAngle, angle) {
			var ctx = wheel.canvasContext,
                centerX = wheel.centerX,
                centerY = wheel.centerY,
                size = wheel.size,
                colors = wheel.seg_color,
                value = wheel.segments[key];

			//ctx.save();
			ctx.beginPath();

			// Start in the centre
			ctx.moveTo(centerX, centerY);
			ctx.arc(centerX, centerY, size, lastAngle, angle, false); // Draw an arc around the edge
			ctx.lineTo(centerX, centerY); // Now draw a line back to the centre

			// Clip anything that follows to this area
			//ctx.clip(); // It would be best to clip, but we can double performance without it
			ctx.closePath();

			ctx.fillStyle = colors[key];
			ctx.fill();
			ctx.stroke();

			// Now draw the text
			ctx.save(); // The save ensures this works on Android devices
			ctx.translate(centerX, centerY);
			ctx.rotate((lastAngle + angle) / 2);

			ctx.fillStyle = whiteHex;
			ctx.fillText(value.substr(0, 20), size-15, 0);
			ctx.restore();
		},

		drawWheel : function() {
			var ctx = wheel.canvasContext,
                angleCurrent = wheel.angleCurrent,
                lastAngle    = angleCurrent,
                len       = wheel.segments.length,
                centerX = wheel.centerX,
                centerY = wheel.centerY,
                size    = wheel.size,
                angle,
                i;

			ctx.lineWidth    = 1;
			ctx.strokeStyle  = blackHex;
			ctx.textBaseline = "middle";
			ctx.textAlign    = "right";
			ctx.font         = "1em Arial";

			for (i = 1; i <= len; i++) {
				angle = doublePI * (i / len) + angleCurrent;
				wheel.drawSegment(i - 1, lastAngle, angle);
				lastAngle = angle;
			}

			// Draw a center circle
			ctx.beginPath();
			ctx.arc(centerX, centerY, 20, 0, doublePI, false);
			ctx.closePath();

			ctx.fillStyle   = whiteHex;
			//ctx.strokeStyle = blackHex;
			ctx.fill();
			ctx.stroke();

			// Draw outer circle
			ctx.beginPath();
			ctx.arc(centerX, centerY, size, 0, doublePI, false);
			ctx.closePath();

			ctx.lineWidth   = 10;
			//ctx.strokeStyle = blackHex;
			ctx.stroke();
		}
	};

  $(function() {
    if($('#wheel-canvas').size() > 0) {
      var contestants2 = $('#wheel-canvas').data('contestants').split('\n');
      var winners2 = $('#wheel-canvas').data('winners');
      wheel.init();

      $.each(contestants2, function(key, contestant) {
        wheel.segments.push( contestant );
      });

        $.each(contestants2, function(key, contestant) {
            contestants.names.push( contestant );
        });

        $.each(winners2, function(key, winner) {
            winners.names.push( winner );
        });



        wheel.update();
    }
	});
}(jQuery));
