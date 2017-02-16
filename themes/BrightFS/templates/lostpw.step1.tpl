	<div style="width: 100%; text-align: center"><a href="<?php echo Filters::noXSS($baseurl); ?>" ><img src="/flyspray.png" alt="FlySpray" width="350" /></a></div>
	<div class="login-wrap">
		<div class="login-html">
			<h3><?php echo Filters::noXSS(L('lostpw')); ?></h3>
			<div class="login-form">
				<?php echo tpl_form(Filters::noXSS(CreateUrl('lostpw'))); ?>
				<input type="hidden" name="action" value="lostpw.sendmagic" />
				<div class="lost-pw">
					<div class="group"><?php echo Filters::noXSS(L('lostpwexplain')); ?></div>
					<div class="group">
						<label for="userlp" class="label"><?php echo Filters::noXSS(L('username')); ?></label>
						<input id="userlp" name="user_name" type="text" class="input" value="<?php echo Filters::noXSS(Req::val('user_name')); ?>" maxlength="20" />
					</div>
					<div class="group">
						<input type="submit" class="ggl button blue" value="<?php echo Filters::noXSS(L('sendlink')); ?>">
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>