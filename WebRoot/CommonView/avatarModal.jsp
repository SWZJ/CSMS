<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 修改头像模态框 -->
<link href="https://cdn.bootcss.com/cropper/3.1.3/cropper.min.css" rel="stylesheet">
<div class="modal fade" id="changeModal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content" style="text-align:center">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title text-primary"><i class="fa fa-file-image-o"></i>更换头像</h4>
        </div>
        <div class="modal-body">
            <p class="tip-info text-center">
                未选择图片
            </p>
            <div class="img-container hidden">
                <img src="" alt="" id="photo">
            </div>
        </div>
        <div class="modal-footer">
            <label class="btn btn-danger pull-left" for="photoInput">
            	<input type="file" class="sr-only" id="photoInput" accept="image/*" style="display:none">选择图片
            </label>
            <button class="btn btn-primary disabled" disabled="disabled" onclick="sendPhoto();">提交</button>
            <button class="btn btn-close" aria-hidden="true" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
</div>
<script src="https://cdn.bootcss.com/cropper/3.1.3/cropper.min.js"></script>
<script type="text/javascript">
        var initCropperInModal = function(img, input, modal){
            var $image = img;
            var $inputImage = input;
            var $modal = modal;
            var options = {
                aspectRatio: 1, // 纵横比
                viewMode: 1,
				scalable: false,//是否允许缩放图像
				zoomable: false,//是否允许放大图像
				movable: false,//是否允许可以移动后面的图片
				rotatable: false,//是否允许旋转图像
				
            };
            // 模态框隐藏后需要保存的数据对象
            var saveData = {};
            var URL = window.URL || window.webkitURL;
            var blobURL;
            $modal.on('show.bs.modal',function () {
                // 如果打开模态框时没有选择文件就点击“打开图片”按钮
                if(!$inputImage.val()){
                    $inputImage.click();
                }
            }).on('shown.bs.modal', function () {
                // 重新创建
                $image.cropper( $.extend(options, {
                    ready: function () {
                        // 当剪切界面就绪后，恢复数据
                        if(saveData.canvasData){
                            $image.cropper('setCanvasData', saveData.canvasData);
                            $image.cropper('setCropBoxData', saveData.cropBoxData);
                        }
                    }
                }));
            }).on('hidden.bs.modal', function () {
                // 保存相关数据
                saveData.cropBoxData = $image.cropper('getCropBoxData');
                saveData.canvasData = $image.cropper('getCanvasData');
                // 销毁并将图片保存在img标签
                $image.cropper('destroy').attr('src',blobURL);
            });
            if (URL) {
                $inputImage.change(function() {
                    var files = this.files;
                    var file;
                    if (!$image.data('cropper')) {
                        return;
                    }
                    if (files && files.length) {
                        file = files[0];
                        if (/^image\/\w+$/.test(file.type)) {
                            if(blobURL) {
                                URL.revokeObjectURL(blobURL);
                            }
                            blobURL = URL.createObjectURL(file);
                            // 重置cropper，将图像替换
                            $image.cropper('reset').cropper('replace', blobURL);
                            // 选择文件后，显示和隐藏相关内容
                            $('.img-container').removeClass('hidden');
                            $('#changeModal .disabled').removeAttr('disabled').removeClass('disabled');
                            $('#changeModal .tip-info').addClass('hidden');
                        } else {
                            window.alert('请选择一个图像文件！');
                        }
                    }
                });
            } else {
                $inputImage.prop('disabled', true).addClass('disabled');
            }
        }

   /*  var sendPhoto = function(){
        $('#photo').cropper('getCroppedCanvas',{
            width:300,
            height:300
        }).toBlob(function(blob){
            // 转化为blob后更改src属性，隐藏模态框
            $('#user-photo').attr('src',URL.createObjectURL(blob));
            $('#changeModal').modal('hide');
        });
    } */

	var sendPhoto = function () {
	// 得到PNG格式的dataURL
	var photo = $('#photo').cropper('getCroppedCanvas', {
        width: 300,
        height: 300
    }).toDataURL('image/png');
 
    /* $.ajax({
        url: 'avatar', // 要上传的地址
        type: 'post',
        data: {
            'imgData': photo
        },
        dataType: 'json',
        success: function (data) {
            if (data.status == 0) {
                // 将上传的头像的地址填入，为保证不载入缓存加个随机数
                /* $('.user-photo').attr('src', '头像地址?t=' + Math.random()); */
                /* $('#changeModal').modal('hide'); */
            /* } else {
                alert(data.info);
            }
        }
    }); */ 
    
    /* window.location.reload(); */
    
    $('#dataURL').val(photo);
    $('#avaterForm').submit();
    
	$('#photo').cropper('getCroppedCanvas',{
        width:300,
        height:300
    }).toBlob(function(blob){
        // 转化为blob后更改src属性，隐藏模态框
        $('#user-photo').attr('src',URL.createObjectURL(blob));
        $('#changeModal').modal('hide');
		/* location.replace(location.href); */
    });
	

}

    $(function(){
        initCropperInModal($('#photo'),$('#photoInput'),$('#changeModal'));
    });
</script>
