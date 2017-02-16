<h2><?php echo Filters::noXSS(L('summary')); ?></h2>
<div class="box">
	<h3><?php echo Filters::noXSS(L('details')); ?></h3>
	<ul class="form_elements">
		<li>
			<label><?php echo Filters::noXSS(L('profileimage')); ?></label>
			<span><?php echo tpl_userlinkavatar($theuser->id, $fs->prefs['max_avatar_size'], 'av_comment'); ?></span>
		</li>
		<li>
			<label><?php echo Filters::noXSS(L('realname')); ?></label>
			<?php echo Filters::noXSS($theuser->infos['real_name']); ?>
		</li>
		<?php if ((!$user->isAnon() && !$fs->prefs['hide_emails'] && !$theuser->infos['hide_my_email']) || $user->perms('is_admin')) { ?>
		<li>
			<label><?php echo Filters::noXSS(L('emailaddress')); ?></label>
			<span><a href="mailto:<?php echo Filters::noXSS($theuser->infos['email_address']); ?>"><?php echo Filters::noXSS($theuser->infos['email_address']); ?></a></span>
		</li>
		<?php } ?>
		<?php if (!empty($fs->prefs['jabber_server'])) { ?>
			<li>
				<label><?php echo Filters::noXSS(L('jabberid')); ?></label>
				<span><?php echo Filters::noXSS($theuser->infos['jabber_id']); ?></span>
			</li>
		<?php } ?>
		<li>
			<label><?php echo Filters::noXSS(L('globalgroup')); ?></label>
			<span><?php echo Filters::noXSS($groups[Flyspray::array_find('group_id', $theuser->infos['global_group'], $groups)]['group_name']); ?></span>
		</li>
		<?php if ($proj->id) { ?>
			<li>
				<label><?php echo Filters::noXSS(L('projectgroup')); ?></label>
				<span style="display: inline-block">
					<?php if ($user->perms('manage_project')) { ?>
						<?php echo tpl_form(Filters::noXSS($baseurl).'index.php?do=user&amp;id='.Filters::noXSS($theuser->id)); ?>
						<select id="projectgroupin" class="s2" name="project_group_in">
														<?php $sel = $theuser->perms('project_group') == '' ? 0 : $theuser->perms('project_group'); ?>
														<?php echo tpl_options(array_merge($project_groups, array(0 => array('group_name' => L('none'), 0 => 0, 'group_id' => 0, 1 => L('none')))), $sel); ?>
													</select>
						<input type="hidden" name="old_group_id" value="<?php echo Filters::noXSS($theuser->perms('project_group')); ?>" />
						<input type="hidden" name="action" value="admin.edituser" />
						<input type="hidden" name="user_id" value="<?php echo Filters::noXSS($theuser->id); ?>" />
						<input type="hidden" name="project_id" value="<?php echo $proj->id; ?>" />
						<input type="hidden" name="onlypmgroup" value="1" />
						<button class="ggl button blue" type="submit"><?php echo Filters::noXSS(L('update')); ?></button>
						<?php echo '</form>'; ?>
					<?php } else {
						if ($theuser->perms('project_group')) {
							echo Filters::noXSS($project_groups[Flyspray::array_find('group_id', $theuser->perms('project_group'), $project_groups)]['group_name']);
						} else {
							echo Filters::noXSS(L('none'));
						}
					} ?>
				</span>
			</li>
		<?php } ?>
		<li>
			<label><a href="<?php echo Filters::noXSS($_SERVER['SCRIPT_NAME']); ?>?opened=<?php echo Filters::noXSS($theuser->id); ?>&amp;status[]="><?php echo Filters::noXSS(L('tasksopened')); ?></a></label>
			<span><?php echo Filters::noXSS($tasks); ?></span>
		</li>
		<li>
			<label><a href="<?php echo Filters::noXSS($_SERVER['SCRIPT_NAME']); ?>?dev=<?php echo Filters::noXSS($theuser->id); ?>"><?php echo Filters::noXSS(L('assignedto')); ?></a></label>
			<span><?php echo Filters::noXSS($assigned); ?></span>
		</li>
		<li>
			<label><?php echo Filters::noXSS(L('comments')); ?></label>
			<span><?php echo Filters::noXSS($comments); ?></span>
		</li>
		<?php if ($theuser->infos['register_date']) { ?>
		<li>
			<label><?php echo Filters::noXSS(L('regdate')); ?></label>
			<span><?php echo Filters::noXSS(formatDate($theuser->infos['register_date'])); ?></span>
		</li>
		<?php } ?>
	</ul>
</div>

<div class="row"><?php if($user->perms('is_admin')): ?><a href="<?php echo CreateURL('edituser', $theuser->id); ?>" class="ggl button blue"><?php echo L('edituser'); ?></a><?php endif; ?></div>
