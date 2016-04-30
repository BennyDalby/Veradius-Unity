$(document).ready( function() {
				
			$(".alert_Table").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('<table width="580px">'
								+'<tr style="background-color:#bbb">'
								+'<td><i>Fluoroscopy (grey left switch)</i></td>'
								+'<td><i>Exposure (blue right switch)</i></td>'
								+'</tr>'
								+'<tr>'
								+'<td>Fluoroscopy</td>'
								+'<td>Single Shot</td>'
								+'</tr>'
								+'<tr>'
								+'<td>Fluoroscopy</td>'
								+'<td>Run</td>'
								+'</tr>'
								+'<tr>'
								+'<td>Fluoroscopy</td>'
								+'<td>Subtract (vascular and pain)</td>'
								+'</tr>'
								+'<tr>'
								+'<td>Fluoroscopy</td>'
								+'<td>Subtract CO2* (if enabled)</td>'
								+'</tr>'
								+'<tr>'
								+'<td>Roadmap*</td>'
								+'<td>Trace*</td>'
								+'</tr>'
								+'<tr>'
								+'<td>Roadmap CO2* (if enabled)</td>'
								+'<td>Trace CO2* (if enabled)</td>'
								+'</tr>'
								+'<table>'
								+'*Only for vascular', 'Left and right key combinations', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				})

			$(".alert_Example").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('<table width="500px">'
									+'<tr style="background-color:#bbb">'
										+'<td><i>Fluoroscopy (grey left switch)</i></td>'
										+'<td><i>Exposure (blue right switch)</i></td>'
									+'</tr>'
									+'<tr>'
										+'<td>Fluoroscopy</td>'
										+'<td>Single Shot</td>'
									+'</tr>'
								+'</table>'
								+'<br><br>'
								+'This means:<br>'
								+'I.	When pressing the left (grey) key of the hand switch or the left pedal of the foot switch you will perform Fluoroscopy.<br>'
								+'II.	When pressing the right (blue) key of the hand switch or the right pedal of the foot switch you will initiate a Single Shot.', 'Example: When chosen skeleton leg you will have by default;', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				})
				
			$(".alert_0").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('No notes here yet.', 'Notes: Way of use', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				})
			
			$(".alert_1").click( function() {
						window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('The term "button" is used for those selections that can be made via the touch screen on the examination monitor of the Mobile View Station or '
								+'C-arm stand touch screen. The operator can click the on-screen buttons using the touch screen.<br><br>'
								+'The term "key" is used for keys on the system with a fixed function.<br><br>'
								+'Throughout this guide, certain typographical conventions have been used in order to clarify instructions. Vertical line symbols: '
								+'The vertical line symbols "||" are used to indicate the name of a button in a screen or a key on a console. Example: click the |Add| button.<br><br>'
								+'Numbers between parentheses refer to a number in the reference images.', 'Notes: Overview of Veradius Unity Controls', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_3").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('In case of emergency, it is possible to start imaging right away, the system will automatically create a "No name" patient.<br><br>'
								+'If the Password protection is enabled and ignored then it is not possible to:<br>'
								+'> Retrieve patients from RIS/HIS with |Get worklist|<br>> Starting previously scheduled examinations<br>'
								+'> Using the export function<br>> Review existing examinations<br>', 'Notes: Start Up: Switch on the system', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_4").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('When the dose level, pulserate or storage has been changed from the default setting you will see an * on the button, so for example Mode*<br><br>'
								+'When the dose level is set to high level this will be indicated on the Fluoroscopy expander by a "+" symbol.<br><br>'
								+'Dose level can now by default also be changed by toggling the |Mode| key on the remote control. '
								+'If changed the mode key will toggle trough the different combinations of fluoroscopy-exposure.', 'Notes: Pre-acquisition:  Available Acquisition Modes/Settings for Fluoroscopy', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_5").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('Storage cannot be changed for exposure. With exposure, high quality images are made that are intended to be saved.<br>', 'Notes: Pre-acquisition: Available Acquisition Modes/Settings for Exposure.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_6").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('When a button is tapped it becomes yellow which means that particular function is active.', 'Notes: Pre-acquisition:  Image Orientation.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_7").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('Prior to using the Exposure key please <u>always</u>  first press the left (grey) '
								+'key of the hand switch or the left pedal of the foot switch for positioning and to control to the correct kV/mA level. '
								+'You need to make a scout image prior to a Single Shot, a (exposure) Run, a Subtraction run or a Trace run, ' 
								+'this to ensure optimal image quality.', 'Notes: Image Acquisition: General: Fluoroscopy / Exposure.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});				
				
			$(".alert_8").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('Under |System| (5) you can tap the button |Auto Run Cycle| (6). With this button enabled the system will '
								+'automatically start playing every run made with the right (blue) key of the hand switch or with '
								+'the right pedal of the foot switch.', 'Notes: Image Acquisition: Roadmap after Subtraction.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_9").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('Lines can be drawn using the mouse, a finger on the touch screen, or the stylus. For best results, it is recommended that you use the stylus.<br><br>'
								+'The draw button is disabled if a drawing contains the maximum number of lines and dots. The maximum that can be stored by the system is 25 lines and 25 dots.'
								+'The Outline tool button is only visible if the Outline tool option is installed.<br><br>'
								+'The outline tool button is disabled if the image is zoomed. The drawing is displayed again when the image is no longer zoomed.<br><br>'
								+'Only one drawing is kept by the system. If another examination becomes current or if another drawing is made, the original drawing is lost.<br><br>'
								+'It is not possible to rotate, flip or mirror an image if an outline drawing is present. If rotation, flipping or mirroring is attempted while a '
								+'drawing is present, the image will not be rotated, flipped or mirrored and a warning is displayed on the examination monitor and the C-arm stand touch screen.<br><br>'
								+'If an image is stored to USB, printed or copied to the reference monitor, the drawing is included. If an image is exported (DICOM), the drawing is not included.', 'Notes: Post-acquisition: Outline tool (Mobile View Station).', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_10").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('The Store button is disabled if there are no empty expanders available.<br><br>'
								+'The stored positions, times and the positions of the runs are lost if another acquisition examination becomes current.<br><br>'
								+'The Selected Run expander is not expanded and is disabled in Live mode, and if no image is displayed.', 'Notes: Post-Acquisition: Position Memory.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_11").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('The Image Processing key is not enabled if Run cycle (13) is active.<br><br>'
								+'After adjustment of the images, press the Image Processing key again to remove the image processing buttons.<br><br>'
								+'Click in the zoom square and press the Delete key (14) to remove the zoom square.', 'Notes: Post Processing on Mobile View Station.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_12").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('The transfer operation can be interrupted at any time if the Veradius is needed for image acquisition. The task will be held in the queue and will be '
								+'restarted during the next transfer operation.<br><br>'
								+'When Radiation Dose Structured Report is enabled in your system this report will only be queued for transfer when the examination, '
								+'to which the report belongs, is closed. An examination is closed by starting a new examination (or even a "No name" patient) or by shutting down the system '
								+'(normal workflow if network connection is outside of the room). Queued DICOM items can be sent by clicking the |Export| button and the |Resume| button.', 'Notes: Archiving stored images.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
				
			$(".alert_13").click( function() {
				window.onscroll = function (event) {
        			 $.alerts._hide();
        		}
					$.alerts.dialogClass = $(this).attr('id'); // set custom style class
					jAlert('Pressing the system Off key for more than 3 seconds immediately removes power to the entire Mobile View Station, including the '
								+'ViewForum workstation and/or the DVD, if installed, which switches off without shutting down and may result in data loss.<br><br>'
								+'If a ViewForum workstation is installed, wait at least 10 seconds between switching the Veradius off and on again, to ensure the workstation starts correctly.<br><br>'
								+'When the system is switched off using the Emergency off key, be aware that mains power is still applied to some '
								+'circuits in the system until the Mobile View Station mains power plug is removed from the socket outlet.', 'Notes: Shut down / Emergency power off.', function() {
						$.alerts.dialogClass = null; // reset to default
					});
				});
			});