# D&D app:
The app has two views, player and gamemaster
## Player view:
Can edit the name, and stats by tapping on the associated box

Initiative and Saving Throws can be rolled at disadvantage or advantage, simply by tapping the associated button. Additionally both allow for custom bonuses, arbitrary for initiative and flat for saving throws The output can be seen on the button for Initiative, and in a popup for saves. Finally initiative can be reset to 0 with a long press.

Health can be healed above max to simulate temporary health, and changed via tapping on the health/damage buttons and inputting the amount to be healed/damaged. Max HP from above is used when auto resetting health, such as after a long rest, or to cap hit dice health restored.

Death saves are used by tapping on the button, long pressing will reset, as will pressing after three of either have been collected

Beneath that are three saveable attacks, long pressing will allow for any custom dice string to be saved. Such as 1d12+15, this includes arbitrary dice such as a d3 or d17 Short pressing the button will roll, and provide an output in a pop up.

From there is the resting windows, long resting will restore health to maximum, and replenish hit dice equal to your level. Short resting will spend a hit dice if any are available of the type displaced below, this will be used to heal, up to your maximum health. You can always see your total hit dice remaining above your hit dice type.

Free dice roll provides a way to roll any one single dice, displaying the output below.

Skills also display output, and are listed in alphabetical order. Their bonuses can all be changed individually, by using the buttons on the right hand side. To roll a skill, press roll, and the output segment will update after it has been calculated.

All values are saved on exit. You can fully setup your character, and it will persist through app closure. It can be fully reset by clearing the app's cache.

## GM view:
You can use the camera to take a picture of any battle map, and can pan and zoom around the captured image.

Units can be added via the '+' button in the bottom right, from there you can enter a name, stats, health, and any resistances/immunities. Placed units can be dragged and dropped, to reflect their battle field position

Short tapping on a unit will bring up its stats and information. Additionally it will have a box where you can a provide an attack bonus, and damage dice to be rolled You can also delete the unit, or edit any of its stats

Long tapping on units will mark them, allowing for damaging multiple at once. From there you can press the fire icon on the bottom right, bring up the save screen. The save screen gives the option for imputing the damage number, save DC, save type, damage type, and the option to save for all or for half.

Like the player view, all units and the image save on app closure.
