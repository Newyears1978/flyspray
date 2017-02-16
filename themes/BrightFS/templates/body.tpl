<?php /* Check if an existing user is logged in */ ?>
<?php if ( !$user->isAnon() || ($user->isAnon() && count($fs->projects) > 0 && $user->can_view_project($proj->id)
	&& Req::val('login') != '1' && $do != 'lostpw'  && $do != 'register') ) { ?>
	<div class="header">
		<div class="container">
			<div class="navbar">
				<a class="logo" href="<?php echo Filters::noXSS($baseurl); ?>"><?php if($fs->prefs['logo']) { ?><img src="<?php echo Filters::noXSS($baseurl.'/'.$fs->prefs['logo']); ?>" alt="Flyspray" /><?php } ?></a>
				<span id="headermenu" onclick="var nv = jQuery('.nav'); if (nv.css('display')=='none') { nv.css('display', 'table-cell'); } else { nv.css('display', 'none'); }"></span>
				<ul class="nav">
					<?php $this->display('links.main.tpl'); ?>
				</ul>
				<ul class="nav nav-right nav-small-text">
					<?php
					if ( !$user->isAnon() )
					{
						$this->display('links.searches.tpl');
						$this->display('links.admin.tpl');
						$this->display('links.user.tpl');
					} else { ?>
						<li><a class="ggl button gray" href="<?php echo Filters::noXSS($baseurl); ?>index.php?do=index&login=1"><?php echo Filters::noXSS(L('login')); ?></a></li>
						<?php if ($user->isAnon() && $fs->prefs['anon_reg'] && !$fs->prefs['only_oauth_reg']) { ?>
							<li><a class="ggl button blue" href="<?php echo Filters::noXSS($baseurl); ?>index.php?do=register"><?php echo Filters::noXSS(L('register')); ?></a></li>
						<?php } ?>
					<?php } ?>
				</ul>
			</div>
		</div>
	</div>
	<?php if ( isset($update_error) ) { ?>
		<div id="updatemsg">
			<span class="bad"> <?php echo Filters::noXSS(L('updatewrong')); ?></span>
			<a href="?hideupdatemsg=yep"><?php echo Filters::noXSS(L('hidemessage')); ?></a>
		</div>
	<?php } ?>
	
	<?php if ( isset($updatemsg) ) {  ?>
		<div id="updatemsg">
			<a href="http://flyspray.org/"><?php echo Filters::noXSS(L('updatefs')); ?></a> <?php echo Filters::noXSS(L('currentversion')); ?>
			<span class="bad"><?php echo Filters::noXSS($fs->version); ?></span> <?php echo Filters::noXSS(L('latestversion')); ?> <span class="good"><?php echo Filters::noXSS($_SESSION['latest_version']); ?></span>.
			<a href="?hideupdatemsg=yep"><?php echo Filters::noXSS(L('hidemessage')); ?></a>
		</div>
	<?php } ?>
	<div class="page-head">
		<label id="labelpmmenu" for="pmmenu"></label>
		<div class="container">
			<div class="page-head-details">
				<?php if ( $user->can_select_project($proj->id) && ($proj->id != 0 || !$fs->prefs['logo']) && $do != 'user' )
				{
					echo '<h1>';
					echo '<a class="project" href="' . Filters::noXSS(CreateUrl('project', $proj->id)) . '"><i class="octicon octicon-repo"></i> ' . Filters::noXSS($proj->prefs['project_title']).'</a>';

					echo ' :: ';
					if ( $do == 'toplevel' ) echo '<a href="' . Filters::noXSS(CreateURL('toplevel', $proj->id)) . '">' . Filters::noXSS(L('overview')) . '</a>';
					elseif ( $do == 'index' && !isset($_GET['dev']) && !isset($_GET['opened']) ) echo '<a href="' . Filters::noXSS(CreateURL('tasklist', $proj->id)) . '">' . Filters::noXSS(L('tasklist')) . '</a>';
					elseif ( $do == 'index' && !isset($_GET['opened']) && isset($_GET['dev']) && $_GET['dev'] == $user->id ) echo '<a href="' . CreateURL('index', $proj->id, null, array('dev'=>$user->id)) . '">' . Filters::noXSS(L('myassignedtasks')) . '</a>';
					elseif ( $do == 'index' && isset($_GET['opened']) ) echo '<a href="' . CreateURL('index', $proj->id, null, array('dev'=>$user->id)) . '">' . Filters::noXSS(L('tasklist')) . '</a> <small>(' . Filters::noXSS(L('openedby')) . ' ' . tpl_userlink(Get::val('opened')) . ')</small>';
					elseif ( $do == 'reports' ) echo '<a href="' . Filters::noXSS(CreateURL('reports', $proj->id)) . '">' . Filters::noXSS(L('reports')) . '</a>';
					elseif ( $do == 'roadmap' ) echo '<a href="' . Filters::noXSS(CreateURL('roadmap', $proj->id)) . '">' . Filters::noXSS(L('roadmap')) . '</a>';
					elseif ( $do == 'pm' ) echo '<a href="' . Filters::noXSS(CreateURL('pm', 'prefs', $proj->id)) . '">' . Filters::noXSS(L('manageproject')) . '</a>';
					elseif ( $do == 'newmultitasks' ) echo '<a href="' . Filters::noXSS(CreateURL('newmultitasks', $proj->id)) . '">' . Filters::noXSS(L('addmultipletasks')) . '</a>';
					elseif ( $do == 'newtask' ) echo '<a href="' . Filters::noXSS(CreateURL('newtask', $proj->id)) . '">' . Filters::noXSS(L('addnewtask')) . '</a>';
					elseif ( $do == 'details' )
					{
						echo '<a href="">';
						echo 'FS#';
						echo Filters::noXSS($task_details['task_id']) . ' - ' . Filters::noXSS($task_details['item_summary']);
						echo '</a>';
					}
					echo '</h1>' ;
				}
				else
				{
					echo '<h1>';
					if ( $do == 'toplevel' ) echo Filters::noXSS(L('projects'));
					elseif ( $do == 'index' && !isset($_GET['dev']) ) echo Filters::noXSS(L('tasksall'));
					elseif ( $do == 'index' && isset($_GET['dev']) && $_GET['dev'] == $user->id ) echo Filters::noXSS(L('myassignedtasks'));
					elseif ( $do == 'reports' ) echo Filters::noXSS(L('reports'));
					elseif ( $do == 'admin' ) echo Filters::noXSS(L('admintoolboxlong'));
					elseif ( $do == 'user' || $do == 'myprofile' ) echo '' . Filters::noXSS(L('profile')) . ' ' . Filters::noXSS($theuser->infos['real_name']) . ' (' . Filters::noXSS($theuser->infos['user_name']) . ')' . '';
					echo '</h1>';
				}
				?>
				<div id="pmcontrol">
					<div id="projectselector"><?php
						# $fs->projects is filtered with can_select_project() for the current user/guest in index.php
						if(count($fs->projects)>0): ?>
							<form id="projectselectorform" action="<?php echo Filters::noXSS($baseurl); ?>index.php" method="get">
							<select class="s2" name="project" onchange="document.getElementById('projectselectorform').submit()">
							<?php echo tpl_options(array_merge(array(0 => L('allprojects')), $fs->projects), $proj->id); ?>
							</select>
							<noscript><button type="submit"><?php echo Filters::noXSS(L('switch')); ?></button></noscript>
							<input type="hidden" name="do" value="<?php echo Filters::noXSS($do); ?>" />
							<input type="hidden" value="1" name="switch" />
								<?php $check = array('area', 'id');
								if ($do == 'reports') {
									$check = array_merge($check, array('open', 'close', 'edit', 'assign', 'repdate', 'comments', 'attachments',
										'related', 'notifications', 'reminders', 'within', 'duein', 'fromdate', 'todate'));
								}
								foreach ($check as $key):
									if (Get::has($key)): ?>
										<input type="hidden" name="<?php echo Filters::noXSS($key); ?>" value="<?php echo Filters::noXSS(Get::val($key)); ?>" />
									<?php endif;
								endforeach; ?>
						</form>
						<?php endif; ?>
					</div>
				</div>
			</div>
		</div>
		<?php $this->display('links.project.tpl'); ?>
	</div>
	<div class="content">
		<div class="container">
			<?php
			$show_message = explode(' ', $fs->prefs['pages_welcome_msg']);
			if ($fs->prefs['intro_message'] && ($proj->id == 0 || $proj->prefs['disp_intro']) && (in_array($do, $show_message)) ) {
				echo '<div class="well">' . TextFormatter::render($fs->prefs['intro_message'], 'msg', $proj->id) . '</div>';
			}
			if ($proj->id > 0)
			{
				$show_message = explode(' ', $proj->prefs['pages_intro_msg']);
				if ($proj->prefs['intro_message'] && (in_array($do, $show_message))) {
					echo '<div class="well">' . TextFormatter::render($proj->prefs['intro_message'], 'msg', $proj->id, ($proj->prefs['last_updated'] < $proj->prefs['cache_update']) ? $proj->prefs['pm_instructions'] : '') . '</div>';
				}
			}
			?>
<?php /* No Public projects found and no one is logged in. Showing login page */ ?>
<?php } else {
	echo '<div><div class="container">';
	if ( $do != 'lostpw'  && $do != 'register' )
	{
		$this->display('login.tpl');
	}
	
} ?>
<!--Page Start Here-->