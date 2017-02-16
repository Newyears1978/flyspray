<?php if ( $do != 'lostpw' ) { ?>
	<div style="width: 100%; text-align: center"><a href="<?php echo Filters::noXSS($baseurl); ?>" ><img src="/flyspray.png" alt="FlySpray" width="350" /></a></div>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab"><?php echo Filters::noXSS(L('login')); ?></label>
			<div class="login-form">
				<form id="login" action="<?php echo Filters::noXSS($baseurl); ?>index.php?do=authenticate" method="post">
					<input type="hidden" name="return_to" value="<?php echo Filters::noXSS($baseurl); ?>" />
					<div class="sign-in-htm">
						<div class="group">
							<label for="user" class="label"><?php echo Filters::noXSS(L('username')); ?></label>
							<input id="user" name="user_name" type="text" class="input" />
						</div>
						<div class="group">
							<label for="pass" class="label"><?php echo Filters::noXSS(L('password')); ?></label>
							<input id="pass" name="password" type="password" class="input" data-type="password" />
						</div>
						<div class="group">
							<input id="remember_login" name="remember_login" type="checkbox" class="check" checked>
							<label for="remember_login"><span class="icon"></span> <?php echo Filters::noXSS(L('rememberme')); ?></label>
						</div>
						<div class="group">
							<input type="submit" class="ggl button blue" value="<?php echo Filters::noXSS(L('login')); ?>">
						</div>
						<?php if (!$fs->prefs['disable_lostpw']) { ?>
							<div class="hr"></div>
							<div class="foot-lnk">
							<?php if ($fs->prefs['user_notify']) { ?>
								<a href="<?php echo Filters::noXSS(CreateURL('lostpw','')); ?>"><?php echo Filters::noXSS(L('lostpassword')); ?></a>
							<?php } else { ?>
							<a href="mailto:<?php echo Filters::noXSS(implode(',', $admin_emails)); ?>?subject=<?php echo Filters::noXSS(rawurlencode(L('lostpwforfs'))); ?>&amp;body=<?php echo Filters::noXSS(rawurlencode(L('lostpwmsg1'))); ?><?php echo Filters::noXSS($baseurl); ?><?php echo Filters::noXSS(rawurlencode(L('lostpwmsg2'))); ?><?php
								if(isset($_SESSION['failed_login'])):
									?><?php echo Filters::noXSS(rawurlencode($_SESSION['failed_login'])); ?><?php
								else:
									?>&lt;<?php echo Filters::noXSS(rawurlencode(L('yourusername'))); ?>&gt;<?php
								endif;
								?><?php echo Filters::noXSS(rawurlencode(L('regards'))); ?>"><?php echo Filters::noXSS(L('lostpassword')); ?></a>
								<script type="text/javascript">var link = document.getElementById('forgotlink');link.href=link.href.replace(/#/g,"@");</script>
							<?php } ?>
						</div>
						<?php } ?>
					</div>
				</form>
			</div>
		</div>
	</div>
<?php } ?>