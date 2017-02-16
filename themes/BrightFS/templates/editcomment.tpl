<div class="box">
	<div class="comment_container">
		<div class="comment_avatar"><?php echo tpl_userlinkavatar($user->id, $fs->prefs['max_avatar_size'], 'av_comment'); ?></div>
		<div class="comment">
			<div class="comment_header">
				<div class="comment_header_actions">
					<?php
						$theuser = new User($comment['user_id']);
						if (!$theuser->isAnon()) {
							if ($theuser->perms('is_admin')) {
								$rank = 'Admin';
							}
							else if ($theuser->perms('manage_project')) {
								$rank = 'Project Manager';
							}
							else {
								$rank = '';
							}

							if (!empty($rank)) {
								echo '<span class="comment_header_usertype">'.Filters::noXSS($rank).'</span>';
							}
						}
					?>
				</div>
				<div class="comment_header_infos"><?php echo tpl_userlink($comment['user_id']); ?> <?php echo Filters::noXSS(L('commentedon')); ?> <?php echo Filters::noXSS(formatDate($comment['date_added'], true)); ?></div>
			</div>
			<div class="commenttext">
				<?php echo tpl_form(CreateUrl('details', $comment['task_id'], 'multipart/form-data')); ?>
					<div class="row">
						<input type="hidden" name="action" value="editcomment" />
						<input type="hidden" name="task_id" value="<?php echo Filters::noXSS($comment['task_id']); ?>" />
						<input type="hidden" name="comment_id" value="<?php echo Filters::noXSS($comment['comment_id']); ?>" />
						<input type="hidden" name="previous_text" value="<?php echo Filters::noXSS($comment['comment_text']); ?>" />
						<?php
						require_once(BASEDIR . '/themes/BrightFS/class.BrightFS.php');
						$brightFS = new BrightFS();
						echo $brightFS->dokuwiki('comment_text', 'comment_text', 10, $comment['comment_text'], (defined('FLYSPRAY_HAS_PREVIEW') ? 'preview' : null), $baseurl);
						?>
						<div id="addlinkbox">
							<?php $links = $proj->listLinks($comment['comment_id'], $comment['task_id']);
							$this->display('common.editlinks.tpl', 'links', $links); ?>
							<?php if ($user->perms('create_attachments')): ?>
								<button class="ggl button gray" style="width:100%;" id="addlinkbox_addalink" tabindex="10" type="button" onclick="addLinkField('addlinkbox')">
								<?php echo Filters::noXSS(L('addalink')); ?>
								</button>
								<button class="ggl button gray" id="addlinkbox_addanotherlink" tabindex="10" style="width:100%; display: none" type="button" onclick="addLinkField('addlinkbox')">
								<?php echo Filters::noXSS(L('addanotherlink')); ?>
								</button>
								<span style="display: none">
								<input tabindex="8" class="text" type="text" size="28" maxlength="100" name="userlink[]" />
								<a class="ggl button red" href="javascript://" tabindex="9" onclick="removeLinkField(this, 'addlinkbox');"><i class="fa fa-remove fa-lg"></i></a><br />
								</span>
								<noscript>
								<input tabindex="8" class="text" type="text" size="28" maxlength="100" name="userlink[]" />
								</noscript>
							<?php endif; ?>
						</div>
						<div id="uploadfilebox">
							<?php $attachments = $proj->listAttachments($comment['comment_id'], $comment['task_id']);
							$this->display('common.editattachments.tpl', 'attachments', $attachments); ?>
							<?php if ($user->perms('create_attachments')): ?>
								<button class="ggl button gray" style="width:100%;" id="uploadfilebox_attachafile" tabindex="7" type="button" onclick="addUploadFields()">
									<?php echo Filters::noXSS(L('uploadafile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
								</button>
								<button class="ggl button gray" id="uploadfilebox_attachanotherfile" tabindex="7" style="width:100%; display: none" type="button" onclick="addUploadFields()">
									<?php echo Filters::noXSS(L('attachanotherfile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
								</button>
								<span style="display: none;"><!-- this span is shown/copied in javascript when adding files -->
									<input tabindex="5" class="file" type="file" size="55" name="userfile[]" />
									<a class="ggl button red" href="javascript://" tabindex="6" onclick="removeUploadField(this);"><i class="fa fa-remove fa-lg"></i></a><br />
								</span>
								<noscript>
									<input tabindex="5" class="file" type="file" size="55" name="userfile[]" />
								</noscript>
							<?php endif; ?>
						</div>
					</div>
					<div class="row">
						<button accesskey="s" tabindex="9" type="submit" class="ggl button green"><?php echo Filters::noXSS(L('saveeditedcomment')); ?></button>
						<a class="ggl button green" href="<?php echo Filters::noXSS(CreateUrl('details', $comment['task_id'])); ?>"><?php echo Filters::noXSS(L('canceledit')); ?></a>
					</div>
				<?php echo '</form>'; ?>
			</div>
		</div>
	</div>
</div>
