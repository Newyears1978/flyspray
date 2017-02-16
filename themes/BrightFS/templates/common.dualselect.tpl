<div class="double_select">
	<div class="dualselect_selected">
		<?php if ( $updown ) { echo '<div style="height: 30px;"></div>'; }?>
		<select class="dualselect_selectable" id="l<?php echo Filters::noXSS($id); ?>" multiple="multiple"
				ondblclick="dualSelect(this, 'r', '<?php echo Filters::noJsXSS($id); ?>')">%s</select>
		<?php if ( $updown ) { echo '<div style="height: 30px;"></div>'; }?>
	</div>
	<div class="dualselect_buttons">
		<button class="ggl button gray" type="button" onmouseup="dualSelect('l', 'r', '<?php echo Filters::noJsXSS($id); ?>')"><span class="dualselect_buttons_text"><?php echo eL('add'); ?> </span>&#x25b6;</button>
		<button class="ggl button gray" type="button" onmouseup="dualSelect('r', 'l', '<?php echo Filters::noJsXSS($id); ?>')">&#x25c0;<span class="dualselect_buttons_text"> <?php echo eL('remove'); ?></span></button>
	</div>
	<div class="dualselect_selected">
		<?php if ( $updown ) { ?><button class="ggl button gray" type="button" onmouseup="selectMove('<?php echo Filters::noJsXSS($id); ?>', -1)">&#x25b2;</button><br /><?php } ?>
		<select id="r<?php echo Filters::noXSS($id); ?>" multiple="multiple"
				ondblclick="dualSelect(this, 'l', '<?php echo Filters::noJsXSS($id); ?>')">%s</select>
		<?php if ( $updown ) { ?><button class="ggl button gray" type="button" onmouseup="selectMove('<?php echo Filters::noJsXSS($id); ?>', 1)">&#x25bc;</button><?php } ?>
		<input type="hidden" value="<?php echo Filters::noXSS(join(' ', $selected)); ?>" id="v<?php echo Filters::noXSS($id); ?>" name="<?php echo Filters::noXSS($name); ?>" />
	</div>
</div>
