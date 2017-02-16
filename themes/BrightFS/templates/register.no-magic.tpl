<?php echo tpl_form(Filters::noXSS(CreateUrl('register')),null,null,null,'id="registernewuser"'); ?>
	<?php if ( 1 == 2 ) { ?>
	<h3><?php echo Filters::noXSS(L('registernewuser')); ?></h3>
	<div class="box">
		<ul class="form_elements wide">
			<li>
				<label for="username"><?php echo Filters::noXSS(L('username')); ?></label>
				<input class="required text" value="<?php echo Filters::noXSS(Req::val('user_name')); ?>" id="username" name="user_name" type="text" size="20" maxlength="32" onblur="checkname(this.value);" /> <?php echo Filters::noXSS(L('validusername')); ?><br /><strong><span id="errormessage"></span></strong>
			</li>
	
			<li>
				<label for="realname"><?php echo Filters::noXSS(L('realname')); ?></label>
				<input class="required text" value="<?php echo Filters::noXSS(Req::val('real_name')); ?>" id="realname" name="real_name" type="text" size="30" maxlength="100" />
			</li>
	
			<li>
				<label for="emailaddress"><?php echo Filters::noXSS(L('emailaddress')); ?></label>
				<input id="emailaddress" value="<?php echo Filters::noXSS(Req::val('email_address')); ?>" name="email_address" class="required text" type="text" size="20" maxlength="100" /> <?php echo Filters::noXSS(L('validemail')); ?>
			</li>
	
			<li>
				<label for="verifyemailaddress"><?php echo Filters::noXSS(L('verifyemailaddress')); ?></label>
				<input id="verifyemailaddress" value="<?php echo Filters::noXSS(Req::val('verify_email_address')); ?>" name="verify_email_address" class="required text" type="text" size="20" maxlength="100" />
			</li>
	
			<?php if (!empty($fs->prefs['jabber_server'])): ?>
			<li>
				<label for="jabberid"><?php echo Filters::noXSS(L('jabberid')); ?></label>
				<input id="jabberid" value="<?php echo Filters::noXSS(Req::val('jabber_id')); ?>" name="jabber_id" type="text" class="text" size="20" maxlength="100" />
			</li>
			<?php endif ?>
	
			<li>
				<label for="notify_type"><?php echo Filters::noXSS(L('notifications')); ?></label>
				<select id="notify_type" name="notify_type">
				<?php echo tpl_options($fs->GetNotificationOptions(), Req::val('notify_type')); ?>
				</select>
			</li>
	
			<li>
				<label for="time_zone"><?php echo Filters::noXSS(L('timezone')); ?></label>
				<select id="time_zone" name="time_zone">
				<?php
					$times = array();
					for ($i = -12; $i <= 13; $i++) {
						$times[$i] = L('GMT') . (($i == 0) ? ' ' : (($i > 0) ? '+' . $i : $i));
					}
				?>
				<?php echo tpl_options($times, Req::val('time_zone', 0)); ?>
				</select>
			</li>
			<?php if($fs->prefs['captcha_securimage']) : ?>
			<li class="captchali">
				<style>
							#captcha_code{width:100px;}
							.captchali .securimage label{width:auto;}
							.captchali .securimage {display:inline-block; width:300px;}
							</style>
				<label for="captcha_code"><?php echo Filters::noXSS(L('registercaptcha')); ?></label>
				<div class="securimage"><?php echo $captcha_securimage_html; ?></div>
			</li>
			<?php endif; ?>
		</ul>
		<div>
			<input type="hidden" name="action" value="register.sendcode" />
			<button type="submit" name="buSubmit" id="buSubmit"><?php echo Filters::noXSS(L('sendcode')); ?></button>
		</div>
		<br />
		<p><?php echo L('note'); ?></p>
	</div>
	<?php } else { ?>
		<div style="width: 100%; text-align: center"><a href="<?php echo Filters::noXSS($baseurl); ?>" ><img src="/flyspray.png" alt="FlySpray" width="350" /></a></div>
		<div class="login-wrap">
		<div class="login-html">
			<span class="tab"><?php echo Filters::noXSS(L('registernewuser')); ?></span>
			<div class="login-form">
				<div class="sign-up-htm">
					<div class="group">
						<label for="username" class="label">Username</label>
						<input id="username" name="user_name" type="text" class="input" onblur="checkname(this.value);" value="<?php echo Filters::noXSS(Req::val('user_name')); ?>">
						<small><?php echo Filters::noXSS(L('validusername')); ?></small><br /><strong><span id="errormessage"></span></strong>
					</div>
					<div class="group">
						<label for="realname" class="label"><?php echo Filters::noXSS(L('realname')); ?></label>
						<input id="realname" name="real_name" type="text" class="input" value="<?php echo Filters::noXSS(Req::val('real_name')); ?>"/>
					</div>
					<div class="group">
						<label for="pass" class="label"><?php echo Filters::noXSS(L('emailaddress')); ?></label>
						<input id="pass" name="email_address" type="text" class="input" value="<?php echo Filters::noXSS(Req::val('email_address')); ?>">
						<small><?php echo Filters::noXSS(L('validemail')); ?></small>
					</div>
					<div class="group">
						<label for="verifyemailaddress" class="label"><?php echo Filters::noXSS(L('verifyemailaddress')); ?></label>
						<input id="verifyemailaddress" name="verify_email_address" type="text" class="input" value="<?php echo Filters::noXSS(Req::val('verify_email_address')); ?>">
					</div>
					<?php if (!empty($fs->prefs['jabber_server'])) { ?>
					<div class="group">
						<label for="jabberid" class="label"><?php echo Filters::noXSS(L('jabberid')); ?></label>
						<input id="jabberid" name="jabber_id" type="text" class="input" value="<?php echo Filters::noXSS(Req::val('jabber_id')); ?>">
					</div>
					<?php } ?>
					<div class="group">
						<label for="notify_type" class="label"><?php echo Filters::noXSS(L('notifications')); ?></label>
						<select class="s2" id="notify_type" name="notify_type" style="width:100%">
							<?php echo tpl_options($fs->GetNotificationOptions(), Req::val('notify_type')); ?>
						</select>
					</div>
					<div class="group">
						<label for="time_zone" class="label"><?php echo Filters::noXSS(L('timezone')); ?></label>
						<select class="s2" id="time_zone" name="time_zone" style="width:100%">
							<?php
							$times = array();
							for ($i = -12; $i <= 13; $i++) {
								$times[$i] = L('GMT') . (($i == 0) ? ' ' : (($i > 0) ? '+' . $i : $i));
							}
							?>
							<?php echo tpl_options($times, Req::val('time_zone', 0)); ?>
						</select>
					</div>
					<div class="group">
						<style>
						#captcha_code{width:100px;}
						.captchali .securimage label{width:auto;}
						.captchali .securimage {display:inline-block; width:300px;}
						</style>
						<label for="captcha_code" class="label"><?php echo Filters::noXSS(L('registercaptcha')); ?></label>
						<div class="securimage"><?php echo $captcha_securimage_html; ?></div>
					</div>
					<div class="group">
						<input type="hidden" name="action" value="register.sendcode" />
						<input type="submit" name="buSubmit" class="ggl button blue" value="<?php echo Filters::noXSS(L('sendcode')); ?>">
					</div>
					<em style="text-align: justify;"><?php echo L('note'); ?></em>
				</div>
			</div>
		</div>
	</div>
	<?php } ?>
</form>
