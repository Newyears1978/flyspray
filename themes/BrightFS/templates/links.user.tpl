<li>
	<?php
	$avatar_size = '25';
	if (is_file(BASEDIR.'/avatars/'.$user->infos['profile_image'])) {
		if (is_file(BASEDIR.'/avatars/'.$avacache[$uid]['profile_image'])) {
			$image = '<img src="'.$baseurl.'avatars/'.$avacache[$uid]['profile_image'].'"/>';
		} else {
			if (isset($fs->prefs['gravatars']) && $fs->prefs['gravatars'] == 1) {
				$email = md5(strtolower(trim($avacache[$uid]['email'])));
				$default = 'mm';
				$imgurl = '//www.gravatar.com/avatar/'.$email.'?d='.urlencode($default).'&s='.$avatar_size;
				$image = '<img src="'.$imgurl.'"/>';
			} else {
				$image = '<i class="fa fa-user" style="font-size:'.$avatar_size.'px"></i>';
			}
		}$avatar_image = '<img src="'.$baseurl.'avatars/'.$user->infos['profile_image'].'"/>';
	} else {
		if (isset($fs->prefs['gravatars']) && $fs->prefs['gravatars'] == 1) {
			$avatar_email = md5(strtolower(trim($user->infos['email_address'])));
			$default = 'mm';
			$avatar_imgurl = '//www.gravatar.com/avatar/'.$avatar_email.'?d='.urlencode($default).'&s='.$avatar_size;
			$avatar_image = '<img src="'.$avatar_imgurl.'"/>';
		} else {
			$avatar_image = '<i class="fa fa-user" style="font-size:'.$avatar_size.'px"></i>';
		}
	}
	?>
	<div class="avatar-container"><a class="dropdown-toggle avatar" data-open-id="user-dd"><?php echo $avatar_image;?></a></div>
	<ul id="user-dd" class="dropdown-menu">
		<li class="dropdown-header"><strong><?php echo $user->infos['real_name']; ?></strong></li>
		<li class="divider"></li>
		<li><a href="<?php echo Filters::noXSS(CreateURL('user', $user->id)); ?>"><?php echo Filters::noXSS(L('viewprofile')); ?></a></li>
		<li><a href="<?php echo Filters::noXSS(CreateURL('myprofile')); ?>"><?php echo Filters::noXSS(L('editmydetails')); ?></a></li>
		<li class="divider"></li>
		<li><a href="<?php echo Filters::noXSS(CreateURL('logout', null)); ?>"><?php echo Filters::noXSS(L('logout')); ?></a></li>
	</ul>
</li>