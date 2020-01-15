#pragma once

#include <boost/asio.hpp>
#include<chrono>

#include <functional>

namespace asioUtil {

	// timeout�t���Ŕ񓯊�����������B
	// handler�͎��s����񓯊�����
	// timeout_handler�̓^�C���A�E�gor�^�C���A�E�g�L�����Z�����̏���
	void deadlineOperation(boost::asio::deadline_timer &timer,
		const int unsigned timeout_ms,
		std::function<void()> handler,
		std::function<void(const boost::system::error_code &)> timeout_handler);

	void deadlineOperation2(boost::asio::deadline_timer &timer,
		const int unsigned timeout_ms,
		std::function<void(const boost::system::error_code &)> timeout_handler);



	class deadlineOperation3 : public std::enable_shared_from_this<deadlineOperation3>{
	private:
		boost::asio::deadline_timer deadline_timer_;
	public:
		deadlineOperation3(boost::asio::io_service &io_service, unsigned int timeout_ms
			, std::function<void(const boost::system::error_code &)> handle_timeout)
			: deadline_timer_(io_service) {

			deadline_timer_.expires_from_now(
				boost::posix_time::milliseconds(timeout_ms));

			deadline_timer_.async_wait(
				[=](const boost::system::error_code &ec) {
				if (ec != boost::asio::error::operation_aborted) {
					handle_timeout(ec);
				}

			});
		};
		virtual ~deadlineOperation3() {
			// �f�X�g���N�^�Ń^�C�}�[�L�����Z������
			deadline_timer_.cancel();
		};
	};

}

